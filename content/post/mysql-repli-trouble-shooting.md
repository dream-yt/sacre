---
title: "MySQLでmasterにDDLを発行したらslaveがクエリを返さなくなったときの対応"
slug: mysql-repli-trouble-shooting
date: 2021-10-22T15:12:08+09:00
draft: false
author: sakamossan
---

MySQLでマスターにカラム追加のDDLを発行したら、スレーブ側でそのカラムを追加したテーブルが読めなくなってしまった。


## 対応

スレーブ側が以下のような単純なクエリでも返ってこなくなってしまった。

```sql
> select id from mytable where id = 1;
```

PK でひいても、数十秒返ってこない。ctrl+c で kill

DDLがスレーブに届いているかを確認する。

```sql
> show create table mytable\G
....
  `rate` decimal(3,2) DEFAULT NULL,
  `is_enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',

```

カラム追加がまだスレーブでは適用できていないようだ。

processlist を見てみたところ、`Waiting for table metadata lock` で止まっているクエリが確認できた。

```sql
> show processlist ;

+---------+----------+-----------------------+-----+---------+------+---------------------------------+----------------------------------------------------------------------------------------------------------+
| Id      | User     | Host                  | db  | Command | Time | State                           | Info                                                                                                     |
+---------+----------+-----------------------+-----+---------+------+---------------------------------+----------------------------------------------------------------------------------------------------------+
| 3172084 | readonly | 10.136.3.143:60522     | myproj | Query   | 611  | Waiting for table metadata lock | SELECT....|
| 3172167 | readonly | 118.38.203.205:49244 | myproj | Query   | 980  | Writing to net                  | SELECT /*!40001 SQL_NO_CACHE */ * FROM `mytable`                                                           |
| 3172260 | readonly | 10.136.1.229:48626     | myproj | Query   | 630  | Waiting for table metadata lock | SELECT.... |
| 3172329 | readonly | 202.32.238.73:40228  | myproj | Sleep   | 31   |                                 | <null>                                                                                                   |
```

これは分析用のクエリということがわかっていたので、これらをkillしたところ、その他のクエリも無事に流れるようになった。

```sql
> kill 3172084
```


## おさらい

- まずスレーブがどこまでマスターに追随できているかを確認する
    - 今回の場合はカラム追加なので `SHOW CREATE TABLE`
- 追随できていないことが分かったら、そのスレッドのせいで詰まったかを確認。
- 原因のクエリをkill


## 謎に思ったこと

マスターからスレーブに流しているクエリはシングルスレッドで動いているというのは理解できて、そのシングルスレッドが詰まってしまった場合には後続の処理も詰まってしまうというのは理解できるのだが、それではなぜ「ローカルからつないで叩いた `select id from mytable where id = 1`」も返ってこなかったのかはちょっと気になる。

マスターで `LOCK NONE` で流しても、スレーブでは適用されなかったりとかがあるのだろうか。


## 参考

- [Waiting for table metadata lockの対処の仕方、おさらい。 - なからなLife](https://atsuizo.hatenadiary.jp/entry/2018/12/08/090000)




