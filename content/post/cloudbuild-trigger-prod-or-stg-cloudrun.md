---
title: "CloudBuild で CloudRun のデプロイをする。ブランチ名によってはstagingにデプロイされるようにする。"
slug: cloudbuild-trigger-prod-or-stg-cloudrun
date: 2021-06-07T23:05:28+09:00
draft: false
author: sakamossan
---

Cloud Build には Build と Trigger の2種類のエンティティがある。

- Build は `step` の設定に沿って実行した実行履歴1つ分
- Trigger は、どういうときに Build が実行されるかを設定するもの

## トリガー

GitHub に push したら処理を動かすように Trigger を設定したい場合はこんなコマンドで登録する。

```bash
$ gcloud beta builds triggers create github  ...
# どんなオプションが渡せるかはhelpで出てくる
$ gcloud beta builds triggers create github --help
```

GCPのUIでトリガーをつくったときはこうすれば yaml で定義をみられる。

```
$ gcloud beta builds triggers list
```

```yaml
createTime: '2020-05-06T13:01:33.647678872Z'
description: master ブランチへの push
filename: site/www/cloudbuild.yaml
github:
  name: myapp
  owner: githubusername
  push:
    branch: ^master$
id: xxxxxxxx-362f-44a3-b7ed-79c3c61e041a
name: master-push-trigger
substitutions:
  _SERVICE: master
tags:
- github-default-push-trigger
```

こんな設定になっている。

- `^master$` に引っかかるブランチ (master ブランチ) にpushしたとき
- `_SERVICE=master` という変数名を埋め込んで
- `site/www/cloudbuild.yaml` に記述されているビルドステップを実行する

もう1つトリガーを作る。そちらはこんな設定をしている。(一部抜粋)

```yaml
...
github:
  push:
    branch: ^canary/
substitutions:
  _SERVICE: canary
...
```

これはつまり、`canary/` という名前で始まるブランチが push されたら、 canary のアプリがデプロイされるという設定になっている。


## cloudbuild.yaml

トリガーによって何が実行されるべきかを書くのが cloudbuild.yaml

```yaml
steps:
  - name: 'gcr.io/cloud-builders/docker'
    id: 'docker-pull'
    # $PROJECT_ID はCloudbuild組み込みの環境変数
    # $_SERVICE はユーザ定義の環境変数 (`_`で始まる必要がある)
    args: ['pull', 'asia.gcr.io/$PROJECT_ID/$_SERVICE:latest']
  - name: 'gcr.io/cloud-builders/docker'
    id: 'docker-build'
    args: [ 'build',
      '--cache-from', 'asia.gcr.io/$PROJECT_ID/$_SERVICE:latest',
      '--tag', 'asia.gcr.io/$PROJECT_ID/$_SERVICE:$REVISION_ID',
      # リポジトリの /site/www/Dockerfile を使ってビルドする
      'site/www'
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
    # _SERVICE はユーザ定義の変数
    # pushしたブランチによってデプロイ先が変わるようにトリガーに設定している
    args: ['beta', 'run', 'deploy', '$_SERVICE',
      # さきほどタグをつけたイメージからデプロイ
      '--image', 'asia.gcr.io/$PROJECT_ID/$_SERVICE:$REVISION_ID',
      '--region', 'asia-northeast1',
      # anthos とかが指定できる。デフォルトも managed
      '--platform', 'managed',
      # wwwに公開する場合は権限がなくてもアクセスできることを明示する
      '--allow-unauthenticated'
    ]
```

- [変数値の置換  |  Cloud Build のドキュメント  |  Google Cloud](https://cloud.google.com/build/docs/configuring-builds/substitute-variable-values?hl=ja)

