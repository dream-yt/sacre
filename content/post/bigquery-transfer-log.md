---
title: "bigqueryのtransfer_configの実行履歴の確認の仕方"
date: 2019-02-24T10:50:59+09:00
draft: false
---

### transfer_config

設定されているtransfer_configを一覧

```bash
$ bq --format=json ls --transfer_config --transfer_location='us' | jq .
```

### transfer_run

`name` を引数に渡してtransfer_runを一覧

```bash
$ bq --format=json ls --transfer_run --transfer_location='us' \
    projects/987573330809/locations/us/transferConfigs/5c5aff8c-0000-285b-bf15-089e08324cf4
```

### summary

実行履歴の成否だけ見たい場合はこんな感じ

```bash
bq --format=json ls --transfer_run --transfer_location='us' \
    projects/987573330809/locations/us/transferConfigs/5c5aff8c-0000-285b-bf15-089e08324cf4 \
    | jq '.[] | { runTime, endTime, state }'
```

```json
{
  "runTime": "2019-02-23T03:00:00Z",
  "endTime": "2019-02-23T03:03:01.601951Z",
  "state": "SUCCEEDED"
}
{
  "runTime": "2019-02-22T03:00:00Z",
  "endTime": "2019-02-22T03:03:05.315392Z",
  "state": "SUCCEEDED"
}
{
  "runTime": "2019-02-21T03:00:00Z",
  "endTime": "2019-02-21T03:04:01.056948Z",
  "state": "SUCCEEDED"
}
...
```


