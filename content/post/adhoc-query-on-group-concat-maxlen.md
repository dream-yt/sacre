---
title: "アドホックなクエリで GROUP_CONCAT を安全に使う"
slug: adhoc-query-on-group-concat-maxlen
date: 2022-01-04T16:43:26+09:00
draft: false
author: sakamossan
---

データメンテナンスなどで MySQL の `GROUP_CONCAT` を使うことがあるが、この関数は要注意で使い方に罠がある。
しかし「罠があるんだよな」ということだけ憶えていて罠を避ける方法を毎回検索していたのでメモっておく。

### 罠

`group_concat_max_len` という環境変数(設定)があり、これがデフォルトで1024である。
結果文字列がこの設定値より文字数が多いと、それ以降の分は切られてしまって結果に出てこない。

これを避けるために `group_concat_max_len` を大きい値に設定しておく必要がある。
なお、アドホックのクエリでなくこの関数を使う場合は my.cnf に設定すること。


### 設定を確認

```sql
SHOW VARIABLES LIKE 'group_concat_max_len';
```


### (大きい値に)設定

```sql
SET group_concat_max_len = 10000000;
```


### 使う

```sql
SELECT GROUP_CONCAT(DISTINCT(order_id) ORDER BY order_id)
FROM logs
WHERE date BETWEEN '2021-12-01' AND '2021-12-31'
```
