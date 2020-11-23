---
title: "cloudrun/cloudscheduler入門"
slug: cloudrun-cloudscheduler-101
date: 2020-02-18T09:09:40+09:00
draft: false
author: sakamossan
---

毎日決まった時間にスクリプトを実行したい要求があったので、マネージドの環境で実行できるcloudrun/cloudschedulerを試してみた

ちなみに、シェルスクリプトを動かしたいだけだったのだがcloudrunはhttpサーバとしてしかデプロイできない。なのでnodejsのexpressサーバが、リクエストを受け取ったら子プロセスでスクリプトを実行するようなやつを用意した

`子プロセスでシェルスクリプトを起動する` コードはこんなようなもの

- [nodejsで標準入出力/エラーを共有した子プロセスを作る · sacre](https://dream-yt.github.io/post/nodejs-spawn-inherit-stdout-stderr/)

今回GCPにやってほしいのは以下の2つ

- cloudrunでコンテナをホスティング
- そのコンテナを決まった時間にcloudschedulerでキックする

#### docker build

環境変数を.envrcでセットしてbuild

```bash
docker build . --tag gcr.io/$GOOGLE_PROJECT_ID/$IMAGE_NAME:$IMAGE_TAG
```

#### ローカルで動作確認

```bash
PORT=8080 && docker run \
  -p 8080:${PORT} \
  -e PORT=${PORT} \
  gcr.io/$GOOGLE_PROJECT_ID/$IMAGE_NAME:$IMAGE_TAG
```

ローカルで実行するやりかたについては公式のドキュメントが参考になった
`GOOGLE_APPLICATION_CREDENTIALS` を `--volume` でマウントする扱いも参考になる

- [コンテナ イメージをローカルでテストする  |  Cloud Run  |  Google Cloud](https://cloud.google.com/run/docs/testing/local)


#### docker push

認証をしてから

```bash
gcloud auth configure-docker
```

GoogleContainerRegistryにpushする

```bash
docker push gcr.io/$GOOGLE_PROJECT_ID/$IMAGE_NAME:$IMAGE_TAG
```

#### gcloud run

以下のコマンドでcloudrunにてコンテナがホストされるようになる

```bash
gcloud beta run deploy $IMAGE_NAME \
  --image gcr.io/$GOOGLE_PROJECT_ID/$IMAGE_NAME:$IMAGE_TAG \
  --platform managed \
  --region asia-northeast1
```

#### gcloud scheduler

serviceアカウントの権限でコンテナをキックするよう設定

```bash
gcloud beta scheduler jobs create http subcommandtesting-sleep-job \
  --schedule "0 */6 * * *" \
  --http-method=GET \
  --uri='https://subcommandtesting-xxxxxx-an.a.run.app/subcommand/sleep' \
  --oidc-service-account-email='sakamoto@pjt-123456.iam.gserviceaccount.com'
```

同じコンテナに対してURLのパスを変えて違うサブコマンドを実行させてみる

```bash
gcloud beta scheduler jobs create http subcommandtesting-die-job \
  --schedule "15 * * * *" \
  --http-method=GET \
  --uri='https://subcommandtesting-xxxxxx-an.a.run.app/subcommand/die' \
  --oidc-service-account-email='sakamoto@pjt-123456.iam.gserviceaccount.com'
```

- [gcloud beta scheduler jobs create http  |  Cloud SDK のドキュメント](https://cloud.google.com/sdk/gcloud/reference/beta/scheduler/jobs/create/http)
- [oidc-service-account-email についての説明](https://cloud.google.com/pubsub/docs/reference/rest/v1/projects.subscriptions#OidcToken)


## ログの確認

しばらくしてきちんと動作しているかログを確認した

#### stackdriverのログをクエリ

```
logName="projects/xxxxx/logs/run.googleapis.com%2Fstdout"
# `:` はLIKE検索になる
textPayload:"sleep"  
timestamp>="2020-02-18T00:00:00+09:00"
```

期待通り子プロセスのログがstackdriverに出ていた

```console
$ gcloud logging read "$(cat ~/develop/cloudrun.logquery)" --format json | jq -r '.[] | "\(.timestamp) - \(.textPayload)"'
2020-02-17T18:00:00.350374Z - sleep...
```
