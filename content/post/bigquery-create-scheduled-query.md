---
title: "BigQuery の Scheduled Query を設定する方法"
date: 2019-04-07T13:48:43+09:00
draft: false
---


### bigqueryの古いUIからの作成手順

- クエリを実行
- 実行結果画面から Schedule Query のボタンから設定

旧UIのURLは `https://bigquery.cloud.google.com/{{ project_id }}`
(新UIからリンクがなくなっている)


### 新UIの「スケジュールされたクエリ」

- ここから設定や実行履歴はみられる
- ただし、新UIからだと新規のScheduledQueryを設定することは出来ない
  - 新規作成ボタンが有効にならず設定をサブミットできない


### コマンドライン(bqコマンド)から設定は?

transfer_configを引数に渡せばできそうだがマニュアルには記載がなかった

ドキュメントには{bigquery => bigquery}の記載もない

- [BigQuery Data Transfer Service の概要  |  BigQuery  |  Google Cloud](https://cloud.google.com/bigquery/docs/transfer-service-overview?hl=ja)

gcsからbigqueryにデータを入れるのをコマンドラインでやっている人は見つかった

- [Serverless data ingestion into BigQuery](http://tamaszilagyi.com/blog/2019/2019-02-10-serverless/)


## 所感

BigQueryはもろもろ過渡期な様子で、あまりクリティカルなところにScheduled Queryを使うのは辛そう
