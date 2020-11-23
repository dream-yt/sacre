---
title: "cloudrun にデプロイする cloudbuild.yaml"
slug: cloudbuild-cloudrun
date: 2020-05-07T23:20:24+09:00
draft: false
author: sakamossan
---

### トリガー

まず、cloudbuildのトリガーをこんな感じで登録しておく

- `^master$` のときに変数が `_SERVICE=service` となるように
- `^canary/` のときに変数が `_SERVICE=service-canary` となるように

### cloudbuild.yaml 

```yaml
timeout: '900s'
steps:
  - name: 'gcr.io/cloud-builders/docker'
    id: 'docker-pull'
    args: ['pull', 'asia.gcr.io/$PROJECT_ID/$_SERVICE:latest']
  - name: 'gcr.io/cloud-builders/docker'
    id: 'docker-build'
    args: [ 'build',
      '--cache-from', 'asia.gcr.io/$PROJECT_ID/$_SERVICE:latest',
      '--tag', 'asia.gcr.io/$PROJECT_ID/$_SERVICE:$REVISION_ID',
      'app'  # Dockerfile がルートディレクトリ以外の場所にあったので
    ]
  - name: 'gcr.io/cloud-builders/docker'
    id: 'docker-tag'
    args: ['tag',
      'asia.gcr.io/$PROJECT_ID/$_SERVICE:$REVISION_ID',
      'asia.gcr.io/$PROJECT_ID/$_SERVICE:latest'
    ]
  - name: 'gcr.io/cloud-builders/docker'
    id: 'docker-push'
    args: ['push', 'asia.gcr.io/$PROJECT_ID/$_SERVICE']
  - name: 'gcr.io/cloud-builders/gcloud'
    id: 'cloudrun-deploy'
    args: ['beta', 'run', 'deploy', '$_SERVICE',
      '--image', 'asia.gcr.io/$PROJECT_ID/$_SERVICE:$REVISION_ID',
      '--region', 'asia-northeast1',
      '--platform', 'managed',
      '--allow-unauthenticated'  # publicなリクエストを受け付ける場合
    ]
```

#### 注意

一番最初は事前に `asia.gcr.io/$PROJECT_ID/$_SERVICE:latest` に
何らかのイメージをpushしておく必要がある


### 権限

なお、cloudbuild から cloudrun にデプロイするときの権限についてはこちらの記事が参考になった

- [Google Cloud Build + Google Cloud Run: Fixing “ERROR: (gcloud.run.deploy) PERMISSION_DENIED: The caller does not have permission” | PHPnews.io](https://phpnews.io/feeditem/google-cloud-build-google-cloud-run-fixing-error-gcloud-run-deploy-permission-denied-the-caller-does-not-have-permission)
