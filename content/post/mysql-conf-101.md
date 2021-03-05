---
title: "bennojoy/mysqlを読みながらMySQLの設定の初歩"
slug: mysql-conf-101
date: 2021-03-05T18:55:22+09:00
draft: false
author: sakamossan
---

- [mysql/my.cnf.Debian.j2 at master · bennojoy/mysql](https://github.com/bennojoy/mysql/blob/master/templates/my.cnf.Debian.j2)

見た目で動作が分からなかったものについてメモ

## [mysqld]

`[mysqld]` のようにブラケットでかこんでる部分はセクションと呼ばれる
セクションにはいろいろあって、それぞれの設定をそこの下に書いていく

- mysqld
- client
- mysqldump
- mysqld_safe ...

たとえばmysqlのサーバ側の設定は`[mysqld]`に記載する
また、たとえばライアントのパスワードを設定したい場合は `[client]` のセクションに書く


#### bind-address

- MySQLサーバへの接続元を絞るためのオプション
- 127.0.0.1 に設定すると外部からは接続できなくなる(localhostからのみつながる)
- 設定しないと デフォルトで `*` と同じになり、どこからでも接続できるようになる


#### character_set_server

どの符号化方式でデータを格納するかを指定する
`[mysqld]` セクションに書く

```
character_set_server = utf8mb4
```


#### skip-external-locking

設定例の記事を見るとだいたいで設定されてる項目

- [MySQL :: MySQL 5.6 リファレンスマニュアル :: 8.10.5 外部ロック](https://dev.mysql.com/doc/refman/5.6/ja/external-locking.html)

MyISAMが1つのデータを複数のDBサーバプロセスが触るようなシステムを想定していてロック機構が存在しているが、それを無効にする設定のようだ
