---
title: "BigQuery の Scheduled Query をCLIから登録/参照"
date: 2020-10-07T19:01:35+09:00
draft: false
author: sakamossan
---

こんなコマンドで登録できる

```bash
$ bq mk \
    --transfer_config \
    --data_source=scheduled_query \
    --target_dataset=mydataset \
    --display_name='daily_update/$tablename' \
    --schedule='every day 18:00' \
    --params="$(cat $filename)"
```

- `--schedule='every day 18:00'` 
    - ここで指定する時間はUTC
- `--params="\$(cat $filename)"` 
    - `{"query":"SELECT 1"}` みたいなJSONが入ってるファイルとする


## 参考

- [BigQuery - scheduled query through CLI - Stack Overflow](https://stackoverflow.com/questions/56636336/bigquery-scheduled-query-through-cli)


## なお

作ったスケジュールクエリをCLIで取得するのはこんな感じ

```bash
$ bq --format=json ls --transfer_config --transfer_location='asia-northeast1' | jq .
```
