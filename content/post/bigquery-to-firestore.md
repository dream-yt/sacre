---
title: "firestoreからbigqueryへのexport手順"
date: 2019-11-12T18:56:11+09:00
draft: false
---

gcsを介して行う


## export from firestore

```
gcloud beta firestore export \
  gs://[BUCKET_NAME] \
  --collection-ids=[COLLECTION_ID_1],[COLLECTION_ID_2]
```

- [データのエクスポートとインポート  |  Firebase](https://firebase.google.com/docs/firestore/manage-data/export-import?hl=ja)


## import to bigquery

```
bq --location=[LOCATION] load \
  --source_format=[FORMAT] \
  [DATASET].[TABLE] \
  [PATH_TO_SOURCE]
```

- [Loading data from Cloud Firestore exports  |  BigQuery  |  Google Cloud](https://cloud.google.com/bigquery/docs/loading-data-cloud-firestore#loading_cloud_firestore_export_service_data)


