---
title: "GoogleSpreadSheetへBigQueryからクエリできるようにする"
date: 2019-02-24T17:28:42+09:00
draft: false
---

こんなコマンドでspreadsheetをbigqueryのテーブルのように使うことができる

```
$ bq mk --external_table_definition=[SCHEMA]@[SOURCE_FORMAT]=[GOOGLE_DRIVE_URL] \
    [DATASET_ID].[TABLE_NAME]
```

実際の値をいれるとこんな感じ

```bash
$ export GOOGLE_SHEETS='https://docs.google.com/spreadsheets/d/1r--MIJGEuZSgx9KMQx4ak59wfwclyAOL9S80cZaV8BM/edit#gid=1436148405'
$ export TABLE_DEF='shop_id:string,shop_name:string,area:string,business:string,genre:string'
$ bq mk --external_table_definition="$TABLE_DEF"@GOOGLE_SHEETS="$GOOGLE_SHEETS" \
    log.test_shops2
```

これだけでgoogle spreadsheetへbigqueryからクエリできるようになる

```console
$ bq query "select shop_id from log.test_shops2 limit 3"
Waiting on bqjob_r31a9b91bc4ce40b1_000001691e9a3eba_1 ... (1s) Current status: DONE
+----------------+
|    shop_id     |
+----------------+
| toh-n          |
| qqqqkin-aoerei |
| tog-n          |
+----------------+
```

### ドキュメント

- [フェデレーション データソースの作成とクエリ  |  BigQuery  |  Google Cloud](https://cloud.google.com/bigquery/federated-data-sources?hl=ja#creating_a_federated_table_using_google_drive)
- [bq コマンドライン ツール リファレンス  |  BigQuery  |  Google Cloud](https://cloud.google.com/bigquery/docs/reference/bq-cli-reference?authuser=0&hl=ja#bq_mk)


## 認証?

`gcloud auth login` 経由で取得したcredentialだとうまく動作しなかった

```console
$ bq mk --external_table_definition=GOOGLE_SHEETS="$GOOGLE_SHEETS" log.test_shops
BigQuery error in mk operation: Access Denied: BigQuery BigQuery: No OAuth token with Google Drive scope was found.
```

service-accountの権限を使ってbqコマンドを叩くと期待通り動作した

```
$ gcloud auth activate-service-account mossan@project-926112.iam.gserviceaccount.com \
    --key-file=./gcp/mossan-key.json
```

原因が公式ドキュメントから読み解けなかったが、
こんなことが書いてあるページを見つけた

> The bq tools does NOT request GDRIVE scope using the default authentication mode, and the --enable_gdrive flag is ignored unless you also provide explicit authentication parameters like an explicit service account

- [Bigquery and Google Sheets · GlobalFishingWatch/pipe-tools Wiki · GitHub](https://github.com/GlobalFishingWatch/pipe-tools/wiki/Bigquery-and-Google-Sheets)

わからん

- service-account経由じゃないとGoogleDriveのscopeが手に入らないのだろうか
- そうすると `--enable_gdrive` とは一体なにに使うのだろう

## カラム

カラム情報を渡さずに `bq mk` するとカラム名が適当な感じになってしまうので、
なるべくテーブル定義はちゃんとやる必要がある

```console
$ bq show log.test_shops
Table project-926112:log.test_shops

   Last modified             Schema               Type     Total URIs   Expiration   Labels
 ----------------- --------------------------- ---------- ------------ ------------ --------
  24 Feb 17:05:53   |- string_field_0: string   EXTERNAL   1
                    |- string_field_1: string
                    |- string_field_2: string
                    |- string_field_3: string
                    |- string_field_4: string
```
