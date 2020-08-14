---
title: "athena(presto)で、dateとtimeからJSTを得る"
date: 2019-08-24T16:00:57+09:00
draft: false
author: sakamossan
---

CloudFrontのログファイルをathenaでテーブルにすると、dateカラムとtimeカラムで別カラムになっている

- [Amazon CloudFront ログのクエリ - Amazon Athena](https://docs.aws.amazon.com/ja_jp/athena/latest/ug/cloudfront-logs.html)

この2つのカラムからdatetime (JST) のカラムを作りたい

### こんな感じでできる

この辺を組み合わせる

- `date_format`
- `from_iso8601_timestamp`
- `AT TIME ZONE 'Asia/Tokyo'`

文字列結合でiso8601フォーマットを作っている

- eg: `2019-08-21T18:04:04Z`

```sql
WITH t AS (
  SELECT
    cdn_access_log.*,
    from_iso8601_timestamp(date_format(date, '%Y-%m-%dT') || time || 'Z') AT TIME ZONE 'Asia/Tokyo' jst_datetime
  FROM
    myproj.cdn_access_log
)
SELECT
  date,
  time,
  jst_datetime
FROM
  t
LIMIT
  3
```

|       date |    time | jst_datetime                       |
| ---------- | ------- | ---------------------------------- |
| 2019-08-21 | 9:04:04 | 2019-08-21 18:04:04.000 Asia/Tokyo |
| 2019-08-21 | 9:04:01 | 2019-08-21 18:04:01.000 Asia/Tokyo |
| 2019-08-21 | 9:04:05 | 2019-08-21 18:04:05.000 Asia/Tokyo |


### 参考

- [Amazon CloudFront ログのクエリ - Amazon Athena](https://docs.aws.amazon.com/ja_jp/athena/latest/ug/cloudfront-logs.html)
- [6.13. Date and Time Functions and Operators — Presto 0.224 Documentation](https://prestodb.github.io/docs/current/functions/datetime.html)
