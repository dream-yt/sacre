---
title: "PostgreSQLで特定期間の日数/時間数などを数える"
slug: psql-day-count
author: iruka
date: 2019-03-16T17:00:00+09:00
draft: false
categories: [ "posgresql" ]
tags: [ "posgresql" ]
---

PostgreSQLで特定期間の日数や時間数などを計算したいときの、計算方法メモ

# date型の場合

そのまま引き算すると整数で日数が出る

例
```
select cast('2019-01-01' as date) - cast('2018-12-01' as date)
```
```
31
```

# timestamp型の場合

そのまま引き算するとinterval型で日数（や時間数）が出る。
ぴったり期間がぴったりXX日じゃなく、XX日とX時間、みたいなときは時間数も出る。

例
```
select cast('2019-01-01 00:00:00' as timestamp) - cast('2018-12-01 12:00:00' as timestamp)
```
```
30 days, 12:00:00
```

## 日数を出したい場合1: epoch from で秒数から割り戻す

秒での引き算に直した後、日数に割り戻して小数点以下を切り捨てる。

例
```
select trunc((extract(epoch from cast('2019-01-01 00:00:00' as timestamp)) - extract(epoch from cast('2018-12-01 12:00:00' as timestamp))) / 60 / 60 / 24)
```
```
30.00
```

## 日数を出したい場合2: extract で日数だけを取り出す

interval型から、日数のみ取り出す。

例
```
select extract('day' from (cast('2019-01-01 00:00:00' as timestamp) - cast('2018-12-01 12:00:00' as timestamp)))
```
```
30.00
```




# 参考
- http://m6u.hatenablog.com/entry/2017/01/12/115633
- https://www.postgresql.jp/document/10/html/datatype-datetime.html
- https://www.postgresql.jp/document/10/html/functions-datetime.html
