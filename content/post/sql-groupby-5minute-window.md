---
title: "SQLで5分ごとの平均を出す"
slug: sql-groupby-5minute-window
date: 2019-12-07T22:26:58+09:00
draft: false
author: sakamossan
---

こんな2カラムがあるテーブルで5分ごとのdurationの平均とかMAXとかをサマりたい

- `duration`
  - doubleが入っている
  - レスポンスを返すまでにかかった時間
- `utc_timestamp`
  - timestampが入っている
  - アクセスされた時刻


## SQL

prestoだとこんな感じ (datetimeがintに変換できればどのDBでもできる)

5分は300秒なので、datetimeをUNIXTIMEに変換して(intにして)  
300でわった商が同じなら同じGROUPに入る

```sql
SELECT
  from_unixtime((CAST(to_unixtime(utc_timestamp) AS INTEGER) / 300) * 300) AT TIME ZONE 'Asia/Tokyo' window,
  AVG(duration), 
  MAX(duration),
  APPROX_PERCENTILE(duration, 0.98)  -- 98パーセンタイル
FROM lblog.api
GROUP BY
  CAST(to_unixtime(utc_timestamp) AS INTEGER) / 300
ORDER BY
  MIN(utc_timestamp)
```

パーセンタイルは他のDBだと工夫しないといけないかもしれない


## 参考

- [6.6. Mathematical Functions and Operators — Presto 0.229 Documentation](https://prestodb.io/docs/current/functions/math.html)
- [6.10. Date and Time Functions and Operators — Presto 0.172 Documentation](https://prestodb.io/docs/0.172/functions/datetime.html)
