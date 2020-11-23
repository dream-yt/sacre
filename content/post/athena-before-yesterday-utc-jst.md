---
title: "athenaのUNIXタイムスタンプなカラムをJSTで一昨日から昨日の範囲でとる場合"
slug: athena-before-yesterday-utc-jst
date: 2019-01-20T12:25:05+09:00
draft: false
author: sakamossan
---

下記の図でJSTでの18日〜19日のデータが欲しい場合のこと

![img_0333](https://user-images.githubusercontent.com/5309672/51434631-ce231580-1ca8-11e9-88ba-886d6df79bbd.png)


## 前提

- 日本で使いたいデータなので「日本時間での一昨日から昨日」
- カラムにはunixタイムスタンプが入っている
- クエリをかける際には探索範囲の節約のためにパーティションの指定が必要
    - athenaでの作業
- DBのパーティションはUTCでの日付で切られている
- パーティションの指定は「現時刻から何日前のdayか」をINTでしか指定できない
    - こんな指定: `day = day(current_date - interval '1' day)`

## UTCは先かあとか

JSTは極東の時間帯 (世界地図では一番右) なので時間が進んでいるところにいる

![image](https://user-images.githubusercontent.com/5309672/51434644-6d480d00-1ca9-11e9-9172-7a367d9c7880.png)

- JSTの方が先に20日になる
- JSTの `20日01:00` の時点ではUTCは `19日16:00`


### 指定するパーティション

JSTの18~19を取得したい場合、
探索範囲とするパーティション(UTC)は17~19


# 諸々の範囲の指定の仕方

![img_0333 2](https://user-images.githubusercontent.com/5309672/51434858-b13d1100-1cad-11e9-9ce9-e12ef28af200.png)


### 何日前を指定するか

パーティションは時間ではなく日付で指定するので
今から何日前のパーティションを範囲とするかを整数で指定する

例えば冒頭の図のNOWの時点で -1(1日前) を指定すると
UTCの軸で19日0:00から19日23:59の範囲を取得することになる


### どの範囲を指定するか

- 最終的に欲しいのは JSTの18の範囲(黄色)の部分
- パーティション(UTC)は(17, 18)を指定できればよい


### 指定の仕方

パーティションで17, 18(緑の部分)を指定するには
日付をまたぐことを考えると以下のように指定する必要がある

- ピンクの時間帯では (-2, -1)
- 黒の時間帯では (-3, -2)

(-3, -1) のパーティションを取得するようにすれば、
かならず黄色の部分の時間帯はカバー出来ることになる


## 緑の範囲から黄色の範囲に絞る

JSTに変換してdayでtranc(切り詰める)ことをすればよい
athena/prestoだと下記の通りになる

```sql
BETWEEN
    date_trunc('day', current_timestamp AT TIME ZONE 'Asia/Tokyo' - interval '1' day) AND
    date_trunc('day', current_timestamp AT TIME ZONE 'Asia/Tokyo' - interval '2' day)
```

日本時間の20日にクエリをかけたとして、
日本時間での日付を指定して範囲を切り出しているので黄色い部分だけが取れる

## 例

```sql
SELECT
    *
FROM
    mydb.mytable
WHERE
    -- UTCでのパーティションの指定の部分
    (
        (
            year = year(current_date - interval '1' day)
            AND month = month(current_date - interval '1' day)
            AND day = day(current_date - interval '1' day)
        )
        OR (
            year = year(current_date - interval '2' day)
            AND month = month(current_date - interval '2' day)
            AND day = day(current_date - interval '2' day)
        )
        OR (
            year = year(current_date - interval '3' day)
            AND month = month(current_date - interval '3' day)
            AND day = day(current_date - interval '3' day)
        )
    )
    -- JSTで望んだ時間だけに絞る部分
    AND from_unixtime(check_result.timestamp / 1000) BETWEEN date_trunc(
        'day',
        current_timestamp AT TIME ZONE 'Asia/Tokyo' - interval '2' day
    )
    AND date_trunc(
        'day',
        current_timestamp AT TIME ZONE 'Asia/Tokyo' - interval '1' day
    )
```
