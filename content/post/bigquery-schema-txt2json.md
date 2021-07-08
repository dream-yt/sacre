---
title: "BigQueryのSchemaをCSV形式からJSON形式に変換する"
slug: bigquery-schema-txt2json
date: 2021-07-08T23:14:59+09:00
draft: false
author: sakamossan
---

BigQueryのスキーマ表現をCSV形式からJSON形式に変換する。

ちなみにCSV形式はこんなもの

```
id:integer,order_id:float,detail:string
```

JSONはperlで生成する

```bash
$ cat ./schema.txt \
    | tr "," "\n" \
    | perl -aF":" -nlE 'say qq({"name":"$F[0]","type":"$F[1]","mode": "NULLABLE"})'  \
    | jq --slurp
```

```json
[
  {
    "mode": "NULLABLE",
    "name": "id",
    "type": "integer"
  },
  {
    "mode": "NULLABLE",
    "name": "order_id",
    "type": "float"
  },
  {
    "mode": "NULLABLE",
    "name": "detail",
    "type": "string"
  }
]
```


## 参考

- [スキーマの指定  |  BigQuery  |  Google Cloud](https://cloud.google.com/bigquery/docs/schemas)
- [jqで連続するオブジェクトを配列にする - Qiita](https://qiita.com/eielh/items/aff045e1689be8e89972)
