---
title: "BigQueryの日付分割テーブルを使う"
slug: bq-time_partitioning_field
date: 2018-10-28T02:24:40+09:00
draft: false
author: sakamossan
---

bigqueryで探索するディスク領域を節約する方法は過去たくさんあった

- `_YYYYMMDD` suffix pattern
- using the `_PARTITIONTIME` pseudo-column
    - これはまだ今でも現役なところが多そう

TIMESTAMPかDATEのカラムをパーティションとして切れる機能が2月に発表された

- [Release Notes  |  BigQuery  |  Google Cloud](https://cloud.google.com/bigquery/docs/release-notes#february_8_2018)
- [Creating and Using Partitioned Tables  |  BigQuery  |  Google Cloud](https://cloud.google.com/bigquery/docs/creating-column-partitions?hl=en)

パーティションにしたカラムをwhere句に入れると、それで探索範囲を節約してくれる  
もちろん、bigqueryの料金も安くなる

注意点としては以下二つ

- まだベータ版
- レガシーSQLの文法は使えなくなる


## 使い方

テーブルを作る時に `--time_partitioning_field` オプションを指定するだけでよい

#### select-insertで作ったテーブルをそうする例

```bash
$ bq query \
    --destination_table grey-sort-challenge:partitioning_magic.nyc_taxi_trips_partitioned \
    --time_partitioning_type=DAY \
    --time_partitioning_field=pickup_datetime \
    --use_legacy_sql=false \
    'select * from `grey-sort-challenge.partitioning_magic.nyc_taxi_trips`'
```

#### jsonファイルから bq mk コマンドで作る例

```bash
$ bq mk --table \
     --time_partitioning_field=created \
     --use_legacy_sql=false \
     mylog.test \
     ./bigquery/test.json
Table 'pjt-192612:mylog.test' successfully created.
```

#### bq show

bq show すると `timePartitioning` という属性が生えている  
以下の例はcreatedというカラムを日付分割パーティションカラムにして作ったテーブルの例

```bash
$ bq show --format=prettyjson mylog.work_status | jq .timePartitioning
{
  "field": "created",
  "type": "DAY"
}
```

今の所は日毎のパーティションしか切れないようだ (`"type": "DAY"`)

#### ちゃんと減ってるか確認

`--dry_run` オプションをつけて `statistics.totalBytesProcessed` を確認

```bash
$ bq query \
     --format=prettyjson \
     --use_legacy_sql=false \
     --dry_run \
     "select distinct(created) from mylog.test where created > '2018-09-22' order by created desc" \
     | jq .statistics.totalBytesProcessed
"42065576"
```

```bash
$ bq query \
     --format=prettyjson \
     --use_legacy_sql=false \
     --dry_run \
     "select distinct(created) from mylog.test where created > '2018-08-22' order by created desc" \
     | jq .statistics.totalBytesProcessed
"69017048"
```

ちゃんとwhere句の日付指定を変更するだけで探索バイト数が減っている(安くなっている)
