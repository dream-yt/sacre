---
title: "BigQuery で定義されているUDFの名前と定義を一覧するスクリプト"
slug: list-bigquery-udf
date: 2022-01-31T10:38:10+09:00
draft: false
author: sakamossan
---

```bash
#!/usr/bin/env bash
set -euo pipefail

readonly TMPFILE=/tmp/_list-udf.txt

bq --format=json ls --routines fn \
    | jq -r '.[].routineReference | "\(.datasetId).\(.routineId)"' \
    > $TMPFILE

for udfid in $(cat $TMPFILE); do
    DEF=$(bq --format=json show --routine "$udfid" | jq -r .definitionBody)
    echo "# $udfid"
    echo '```'
    echo ${DEF}
    echo '```'
    echo ""
done
```
