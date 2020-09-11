---
title: "MySQL の CREATE TABLE から BigQuery のスキーマ(json)を生成する"
date: 2020-09-11T13:43:11+09:00
draft: false
author: sakamossan
---

ddlparseというモジュールを使うと簡単だった

- [shinichi-takii/ddlparse: DDL parase and Convert to BigQuery JSON schema and DDL statements](https://github.com/shinichi-takii/ddlparse)

コードはこれだけでよい

```python
import sys
from ddlparse import DdlParse

sql = sys.stdin.read()
table = DdlParse().parse(sql)
print(table.to_bigquery_fields())
```

こんな感じで生成される

```console
$ cat /tmp/__.sql | python ./generate-bigquery-schema-from-mysql-create-table.py  | jq . | head
[
  {
    "name": "id",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "name",
    "type": "string",
    "mode": "REQUIRED"
```
