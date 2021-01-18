---
title: "MySQLでテーブルごとのデータ容量とインデックスの容量を一蘭する"
slug: show-mysql-disk-volume-by-table
date: 2021-01-13T12:52:47+09:00
draft: false
author: sakamossan
---

こんなクエリで出せる

```sql
SELECT table_name,
    (data_length + index_length) / 1000000 mb,
    data_length / 1000000 data_mb,  -- 実データの容量
    index_length / 1000000 idx_mb   -- インデックスデータの容量
FROM information_schema.tables -- 後述
WHERE table_schema = database() -- ユーザー定義のテーブルに絞る
ORDER BY data_length DESC;
```

データベース内の合計だとこんな感じ

```sql
SELECT table_name,
    SUM(data_length + index_length) / 1000000 mb,
    SUM(data_length) / 1000000 data_mb,
    SUM(index_length) / 1000000 idx_mb
FROM information_schema.tables -- 後述
WHERE table_schema = database() -- ユーザー定義のテーブルに絞る

```


## information_schema.tables

この他にも `AVG_ROW_LENGTH` とかパッと見れるとよさそうなカラムがある

```sql
+-----------------+---------------------+------+-----+---------+-------+
| Field           | Type                | Null | Key | Default | Extra |
+-----------------+---------------------+------+-----+---------+-------+
| TABLE_CATALOG   | varchar(512)        | NO   |     |         |       |
| TABLE_SCHEMA    | varchar(64)         | NO   |     |         |       |
| TABLE_NAME      | varchar(64)         | NO   |     |         |       |
| TABLE_TYPE      | varchar(64)         | NO   |     |         |       |
| ENGINE          | varchar(64)         | YES  |     | <null>  |       |
| VERSION         | bigint(21) unsigned | YES  |     | <null>  |       |
| ROW_FORMAT      | varchar(10)         | YES  |     | <null>  |       |
| TABLE_ROWS      | bigint(21) unsigned | YES  |     | <null>  |       |
| AVG_ROW_LENGTH  | bigint(21) unsigned | YES  |     | <null>  |       |
| DATA_LENGTH     | bigint(21) unsigned | YES  |     | <null>  |       |
| MAX_DATA_LENGTH | bigint(21) unsigned | YES  |     | <null>  |       |
| INDEX_LENGTH    | bigint(21) unsigned | YES  |     | <null>  |       |
| DATA_FREE       | bigint(21) unsigned | YES  |     | <null>  |       |
| AUTO_INCREMENT  | bigint(21) unsigned | YES  |     | <null>  |       |
| CREATE_TIME     | datetime            | YES  |     | <null>  |       |
| UPDATE_TIME     | datetime            | YES  |     | <null>  |       |
| CHECK_TIME      | datetime            | YES  |     | <null>  |       |
| TABLE_COLLATION | varchar(32)         | YES  |     | <null>  |       |
| CHECKSUM        | bigint(21) unsigned | YES  |     | <null>  |       |
| CREATE_OPTIONS  | varchar(255)        | YES  |     | <null>  |       |
| TABLE_COMMENT   | varchar(2048)       | NO   |     |         |       |
+-----------------+---------------------+------+-----+---------+-------+
21 rows in set
Time: 0.026s
```
