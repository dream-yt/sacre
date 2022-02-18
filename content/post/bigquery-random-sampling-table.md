---
title: "BigQuery でランダムサンプリングしたテーブルを作る"
slug: bigquery-random-sampling-table
date: 2022-02-01T23:19:06+09:00
draft: false
author: sakamossan
---

大きいテーブルに色々クエリをかけるとお金がかかっちゃうので、ランダムで抽出したテーブルを作成するときのもの。

1%にサンプリングしたテーブルはこのように作成できる。

```sql
CREATE TABLE
  sample.logs
AS
  SELECT * FROM lake.logs_* WHERE RAND() < 0.01
```

無事に1%くらいになった。

```sql
SELECT COUNT(1) FROM t_lake.sales_* UNION ALL
SELECT COUNT(1) FROM sample.sales
```

|       f0_ |
| --------- |
| 2,090,888 |
|    20,969 |
