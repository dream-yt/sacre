---
title: "Cloud Function の `oidc-service-account-email` が必要とするService Account のロール"
slug: cloudfunction-oidc-service-account-email-requires
date: 2022-02-15T14:02:53+09:00
draft: false
author: sakamossan
---

きちんと調べずに使っていたのでメモ

Cloud Function は public アクセスを許可しないで、サービスアカウントからのアクセスのみ許可する設定ができる。
具体的には `--allow-unauthenticated=false` として関数をデプロイすると認証が必要になる。

認証が必要になっている関数にアクセスするには Open ID Connect で発行したトークンが必要になるが、Cloud Task などで関数にリクエストさせる場合は `--oidc-service-account-email` オプションなどをつけて、「どのサービスアカウントで関数にアクセスするか」を指示する必要がある。

もちろん指定するサービスアカウントはなんでもいいわけではなくて、`function.invoker` ロールがついている必要がある。


## 参考

- [cloudfunctions.invoker | Cloud Functions IAM Roles  |  Cloud Functions Documentation  |  Google Cloud](https://cloud.google.com/functions/docs/reference/iam/roles#cloudfunctions.invoker)
- [HTTP Target タスクの作成  |  Cloud Tasks のドキュメント  |  Google Cloud](https://cloud.google.com/tasks/docs/creating-http-target-tasks)
- [GCP からの HTTP リクエストをセキュアに認証する. はじめに | by Yuki Furuyama | google-cloud-jp | Medium](https://medium.com/google-cloud-jp/gcp-%E3%81%8B%E3%82%89%E3%81%AE-http-%E3%83%AA%E3%82%AF%E3%82%A8%E3%82%B9%E3%83%88%E3%82%92%E3%82%BB%E3%82%AD%E3%83%A5%E3%82%A2%E3%81%AB%E8%AA%8D%E8%A8%BC%E3%81%99%E3%82%8B-dda4933afcd6)
