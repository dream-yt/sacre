---
title: "CloudTaskで認証のついたCloudFunctionを実行するまで"
slug: cloudtask-kick-authenticated-cloudfunction
date: 2022-01-27T16:36:24+09:00
draft: false
author: sakamossan
---


CloudTaskは、任意の場所にhttpリクエストを投げてくれるようなサービスで、リトライやワーカーの管理(同時実行数など)が設定できる。

CloudFunction を CloudTask から認証付きでキックする場合はざっくり以下のような手続きとなる。

- まず CloudFunction をデプロイ
    - http エンドポイントモードでデプロイする
    - `--allow-unauthenticated` はつけない
        - 認証が必要な関数としてデプロイする
- CloudTask のキューを作成
    - ジョブのリトライ数などはここで設定
- 作成した CloudTask キューにジョブを追加
    - `--url` でさきほど作ったhttpエンドポイントを叩くように設定
    - `--oidc-service-account-email` で関数の実行権限があるアカウントを指定する


## 前提

たとえば下記のような設定で関数をデプロイして、ジョブを追加する場合。

```bash
export QUEUE_NAME="..."
export CLOUD_FUNCNAME="..."
export URL="https://..."
export SERVICE_ACCOUNT="...@prod-name-123456.iam.gserviceaccount.com"
```

## CloudFunctionのリリース

```bash
# CloudFunctionごとにインスタンスのスペックやタイムアウトの設定
option="--timeout=540 --memory=1024MB "

# memory増やしてもCPUは比例して大きくならないかもしれない
# https://pc.atsuhiro-me.net/entry/2021/01/10/230254
gcloud functions deploy $CLOUD_FUNCNAME \
    --source=./dist \
    --entry-point=$CLOUD_FUNCNAME \
    --trigger-http \
    --region=asia-northeast1 \
    --runtime=nodejs14 \
    $option
```

リリース時に「認証不要のエンドポイントにしますか?」とプロンプトされるのでNoを選択。


## CloudTaskキューの作成

- [gcloud tasks queues create  |  Cloud SDK Documentation  |  Google Cloud](https://cloud.google.com/sdk/gcloud/reference/tasks/queues/create)


```bash
$ gcloud tasks queues create "${QUEUE_NAME}" \
    --location=asia-northeast1 \
    --log-sampling-ratio=1.0 \
    --max-concurrent-dispatches 36 \
    --max-attempts=1
```

## CloudTaskキューにジョブを追加

- [gcloud beta tasks create-http-task  |  Cloud SDK Documentation  |  Google Cloud](https://cloud.google.com/sdk/gcloud/reference/beta/tasks/create-http-task)

```bash
$ gcloud tasks create-http-task \
    --location=asia-northeast1 \
    --queue="${QUEUE_NAME}" \
    --url="https://asia-northeast1-${URL}" \
    --header=content-type:application/json \
    --oidc-service-account-email="${SERVICE_ACCOUNT}" \
    --body-file="/tmp/_.json"
```


## 参考

- [Cloud TasksのワーカーとしてCloud Runを利用する - goodbyegangsterのブログ](https://goodbyegangster.hatenablog.com/entry/2021/07/31/205847)
- [Cloud Tasksを使ってみた](https://zenn.dev/nananaoto/articles/bd1584c77e46f128a41a)
