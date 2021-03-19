---
title: "BigQueryでアクセスログを掘るときのtips"
slug: bigquery-log-digging-tips
date: 2021-03-19T16:32:13+09:00
draft: false
author: sakamossan
---

毎回ググるところがあるのでメモをしておく。
たとえばこんなクエリでアクセス履歴を見ることが多い。

```sql
SELECT user_id,
  FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', time, 'Asia/Tokyo') AS jst,
  status_code,
  SUBSTR(url, 0, 50) url,
  JSON_EXTRACT(parameters, '$.started_at') started_at,
  JSON_EXTRACT(parameters, '$.ended_at') ended_at,
  SUBSTR(parameters, 0, 50) snipped_param
FROM ds.app_access_log
WHERE time BETWEEN '2021-03-19 03:25:00' AND '2021-03-19 03:30:00'
ORDER BY user_id,
  time
```

### 時間を日本時間で表示する

```sql
FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', time, 'Asia/Tokyo') AS jst,
```

### 長い文字列をスニップする

POSTパラメータとか、全部表示すると見づらくなるので少しだけ表示しておく

```sql
SUBSTR(parameters, 0, 50) snipped_param
```

### JSONから値を取得する

POST/GETパラメータの中身から値を取得

```sql
JSON_EXTRACT(parameters, '$.started_at') started_at,
```

## 参考

- [標準 SQL の JSON 関数  |  BigQuery  |  Google Cloud](https://cloud.google.com/bigquery/docs/reference/standard-sql/json_functions?hl=ja)
