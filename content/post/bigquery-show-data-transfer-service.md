---
title: "BigQueryのtransfer_configを表示する"
slug: bigquery-show-data-transfer-service
date: 2019-01-29T22:32:51+09:00
draft: false
author: sakamossan
---

以下の要領で表示できる

```bash
$ bq --format=json ls --transfer_config --transfer_location='us'
$ bq show --transfer_config projects/123456789/locations/us/transferConfigs/xxxxxx
```

出力される設定はこんな感じ ( `--format=json` )

`bq mk` にこの形式のjsonを食わせると設定できるのだろうか? 🤔

```json
$ bq --format=json show --transfer_config projects/123456789/locations/us/transferConfigs/xxxxxxxx-0000-2048-b627-883d24f91f64 | jq .
{
  "updateTime": "2019-01-29T12:48:17.520921Z",
  "destinationDatasetId": "ds_name",
  "displayName": "thit_is_name",
  "name": "projects/123456789/locations/us/transferConfigs/xxxxxxxx-0000-2048-b627-883d24f91f64",
  "schedule": "every day 03:00",
  "datasetRegion": "us",
  "userId": "0294758398920876072",
  "scheduleOptions": {},
  "state": "SUCCEEDED",
  "dataSourceId": "scheduled_query",
  "nextRunTime": "2019-01-30T03:00:00Z",
  "params": {
    "query": "MERGE a.b AS girls USING ..."
  }
}
```
