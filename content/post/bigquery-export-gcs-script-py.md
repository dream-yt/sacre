---
title: "bigqueryのクエリ結果をgcsに出力するスクリプト"
slug: bigquery-export-gcs-script-py
date: 2019-08-10T16:24:49+09:00
draft: false
author: sakamossan
---

こんな段取りで行う

- テンポラリなテーブルを作って、そこにクエリの結果を入れる
- そのテンポラリなテーブルを、データエクスポート機能を使ってgcsに送る

```python
import os
import datetime
from google.cloud import bigquery


DATASET_ID = os.getenv("BQ_DATASET_ID")

def export_to_gcs(query: str, destination_uri: str):
    client = bigquery.Client()
    temp_table_name = 'temp_to_gcs_' + datetime.datetime.now().strftime("%Y%m%d_%H%M")
    temp_table_ref = client.dataset(DATASET_ID).table(temp_table_name)

    # query configuration
    job_config = bigquery.QueryJobConfig()
    job_config.destination = temp_table_ref
    job_config.write_disposition = 'WRITE_TRUNCATE'
    query_job = client.query(query, job_config=job_config)

    try:
        query_job.result()  # waiting
        # transport to gcs
        client.extract_table(temp_table_ref, destination_uri)
    finally:
        client.delete_table(temp_table_ref)


if __name__ == '__main__':
    query = "SELECT * FROM testds20180123.testable"
    export_to_gcs(query, 'gs://xxxx-bq-output/public/test/test2.csv')
```

- [テーブルデータのエクスポート  |  BigQuery  |  Google Cloud](https://cloud.google.com/bigquery/docs/exporting-data?hl=ja)
- [google.cloud.bigquery.client.Client.extract_table — google-cloud 0.28.1 documentation](https://google-cloud.readthedocs.io/en/latest/bigquery/generated/google.cloud.bigquery.client.Client.extract_table.html)
