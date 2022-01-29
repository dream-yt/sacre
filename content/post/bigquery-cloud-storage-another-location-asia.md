---
title: "BigQuery の 外部テーブルに GCS 使おうとして location でダメだった"
slug: bigquery-cloud-storage-another-location-asia
date: 2022-01-29T22:35:17+09:00
draft: false
author: sakamossan
---

先に結論

- Cloud Storage には `asia` ロケーションがある
- BigQuery には `asia` ロケーションがない
- BigQuery はロケーションが違うオブジェクトを外部テーブルにはできない

## 経緯

GCS に置いてある CSVファイルを BigQuery の 外部テーブルとしてロードしようとしたが、以下のエラーが返された。

> Cannot read and write in different locations: source: asia, destination: asia-northeast1

なお、それぞれのロケーションはこんな感じだった。

- Cloud Storage: `asia` (Multi Region)
- BigQuery: `asia-northeast1`

## 原因

Multi Region についてよく分かってなかったが、`asia` と `asia-northeast1` では当然違うロケーション扱いになるようだ。BigQuery はロケーションの違うオブジェクトを外部テーブルとしてくれないのでダメである。

まだ BigQuery にはデータは入れてなかったので、BigQuery のロケーションを `asia` に移動しようとしたが、BigQuery ではまだ `asia` が用意されていなかった。どうやら現状だと Cloud Storage のロケーションを変えないとダメなようだ...
