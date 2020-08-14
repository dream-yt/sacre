---
title: "Bigquery Data Transfer Service について"
date: 2019-01-29T08:43:23+09:00
draft: false
author: sakamossan
---

`$ bq mk --table --help` で今まで知らなかったオプションを見つけた

```
  --[no]transfer_config: Create transfer config.
  --[no]transfer_run: Creates transfer runs for a time range.
```

アドタグやGAのデータを自動的にBigQueryに取り込める設定のようだ

- [BigQuery Data Transfer Service の概要  |  BigQuery  |  Google Cloud](https://cloud.google.com/bigquery/docs/transfer-service-overview?hl=ja)

GCSから取り込む設定もある

- [Cloud Storage の転送に関する概要  |  BigQuery  |  Google Cloud](https://cloud.google.com/bigquery/docs/cloud-storage-transfer-overview?hl=ja)

本当はBigQuery => MergeコマンドでBigQuery の転送がやりたいが、今はサポートされていない

> 現在、BigQuery Data Transfer Service を使用して BigQuery からデータを転送することはできません。

ただ、`現在` って書いてあるってことはそのうち出来るようになるのかもしれない
