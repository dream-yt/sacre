---
title: "BigQueryで UNNEST のやりかた"
date: 2019-06-26T17:40:01+09:00
draft: false
---

UNNEST は配列をフラットなレコードに直すための関数

こんなログデーブルがあったとして、post_arrayの配列をほぐしてフラットなレコードにしたいとする

```sql
+---------------------+--------------------------+---------------------------------------------------------+
|        time         |  login_id      |                           post_array                 |
+---------------------+--------------------------+---------------------------------------------------------+
| 2012-05-14 07:30:52 | NULL           |                                              ["122174"] |
| 2012-06-11 06:01:50 | NULL           |                            ["122225","122226","122227"] |
| 2012-05-02 07:25:12 | bar@test.com   |                                     ["126773","126203"] |
| 2012-05-13 06:23:36 | bar@test.com   |                   ["122320","122322","122323","122326"] |
| 2012-05-24 05:10:44 | dummy@test.jp  | ["122210","122272","122227","122200","122201","122222"] |
| 2012-05-22 07:22:52 | dummy@test.jp  |                                              ["123427"] |
| 2012-06-20 02:21:52 | foo@testap.com |                                              ["113110"] |
| 2012-05-02 07:10:02 | foo@test.com   |                                              ["126005"] |
+---------------------+--------------------------+---------------------------------------------------------+
```

こんなクエリでそれができる

```sql
SELECT
  time,
  login_id,
  post_id
FROM
  `proj.log.post`,
  UNNEST(post_array) AS post_id
```

結果はこんな感じ

```
+---------------------+------------------------------+
|        time         |      login_id  | creative_id |
+---------------------+------------------------------+
| 2012-06-20 02:21:52 | foo@testap.com |      113110 |
| 2012-05-14 07:30:52 | NULL           |      122174 |
| 2012-06-11 06:01:50 | NULL           |      122225 |
| 2012-06-11 06:01:50 | NULL           |      122226 |
| 2012-06-11 06:01:50 | NULL           |      122227 |
| 2012-05-02 07:25:12 | bar@test.com   |      126773 |
| 2012-05-02 07:25:12 | bar@test.com   |      126203 |
| 2012-05-13 06:23:36 | bar@test.com   |      122320 |
| 2012-05-13 06:23:36 | bar@test.com   |      122322 |
| 2012-05-13 06:23:36 | bar@test.com   |      122323 |
| 2012-05-13 06:23:36 | bar@test.com   |      122326 |
| 2012-05-24 05:10:44 | dummy@test.jp  |      122210 |
| 2012-05-24 05:10:44 | dummy@test.jp  |      122272 |
| 2012-05-24 05:10:44 | dummy@test.jp  |      122227 |
| 2012-05-24 05:10:44 | dummy@test.jp  |      122200 |
| 2012-05-24 05:10:44 | dummy@test.jp  |      122201 |
| 2012-05-24 05:10:44 | dummy@test.jp  |      122222 |
| 2012-05-22 07:22:52 | dummy@test.jp  |      123427 |
| 2012-05-02 07:10:02 | foo@test.com   |      126005 |
+---------------------+--------------------------+---+
```

FROM句の後ろに書くのがポイントなのだが、これってCROSS JOINになっちゃうんじゃないの、と思うけど結果は当該行とその行内の配列のJOINという風になる

これは相関交差結合というらしい

> これは相関交差結合です。UNNEST 演算子は、以前に FROM 句に指定したソーステーブルの各行から ARRAY の列を参照します。ソーステーブルの N 行ごとに、UNNEST は、ARRAY の行 N を ARRAY 要素を含む一連の行にフラット化し、CROSS JOIN がこの新しい行のセットをソーステーブルの単一行 N と結合します。

- [標準 SQL での配列の操作  |  BigQuery  |  Google Cloud](https://cloud.google.com/bigquery/docs/reference/standard-sql/arrays?hl=ja#flattening-arrays)


## 参考

SQL標準とかはどうなのかな、と思ったがpostgres,prestoにもUNNEST関数があるようだ

- [7.2. テーブル式](https://www.postgresql.jp/document/9.6/html/queries-table-expressions.html)