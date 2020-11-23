---
title: "ERROR: (gcloud.beta.scheduler.jobs.create.http) INVALID_ARGUMENT"
slug: cloudscheduler-error-INVALID_ARGUMENT
date: 2020-02-17T09:48:04+09:00
draft: false
author: sakamossan
---

GCPのCloudSchedulerの設定で以下のようなコマンドを叩いたところエラーとなった

```bash
gcloud beta scheduler jobs create http subcommandtesting-out-job \
  --schedule "5 * * * *" \
  --http-method=GET \
  --uri='https://test-iujvxwvxra-an.a.run.app/test/out' \
  --oidc-service-account-email='xxxxxxxx@gmail.com'
```

> ERROR: (gcloud.beta.scheduler.jobs.create.http) INVALID_ARGUMENT: Request contains an invalid argument.

この場合、これは `xxxxxxxx@gmail.com` なメールアドレスを使ったのがよくない。`service-account-email` というパラメータ名なので...

きちんとサービスアカウントのメールアドレスを使う必要がある

- `xxxxxxxx@wwwwwwww-123456.iam.gserviceaccount.com`

