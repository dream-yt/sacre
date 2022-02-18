---
title: "BigQuery の CREATE TABLE の便利な機能色々"
slug: useful-bigquery-createtable-statement
date: 2022-02-18T19:11:21+09:00
draft: false
author: sakamossan
---

便利なところ

- `PARTITION BY` や `CLUSTER BY` も CREATE TABLE 文でできてしまう
- `CREATE OR REPLACE TABLE` とできる
- SELECT の結果から作成する場合には SELECT に WITH句が使える
- `OPTIONS(description = "")` として、メモやタグなどがつけられる

### 例

```sql
CREATE OR REPLACE TABLE d.t2
PARTITION BY date
CLUSTER BY customer_id 
OPTIONS(description = "") AS
WITH t AS (SELECT * FROM `d.t_*` )
SELECT parse_DATE('%Y%m%d', ymd) date FROM t
```

## 参考

- [標準 SQL のデータ定義言語（DDL）ステートメント  |  BigQuery  |  Google Cloud](https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#clustering_column_list)
