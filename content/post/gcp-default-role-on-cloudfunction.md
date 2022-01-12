---
title: "Cloud Function とデフォルトでついている権限についてメモ"
slug: gcp-default-role-on-cloudfunction
date: 2022-01-12T12:04:51+09:00
draft: false
author: sakamossan
---

- ランタイムの権限
    - Cloud Function の関数の中での権限
- リソース管理の権限
    - Cloud Function をビルド/デプロイなどするときの権限

## ランタイムの権限

デフォルトでは CloudFunction は `PROJECT_ID@appspot.gserviceaccount.com` という、いろいろできる権限が与えられる。このようなGCPが自動生成してくれるIAMは `Google 管理サービス アカウント` と呼ばれる。

> デフォルトでは、Cloud Functions はランタイムに App Engine のデフォルトのサービス アカウント（PROJECT_ID@appspot.gserviceaccount.com）を使用します。このアカウントには、プロジェクトの編集者のロールが付与されています。このサービス アカウントのロールを変更して、実行中の関数に対する権限を制限または拡張できます。

デフォルトの権限はある意味に初心者向けのスターターパックのようなものだが、厳密な権限管理やランタイムで色々なことをしようとするときには自前でつくったサービスアカウントを設定したり、またはこの `Google 管理サービス アカウント` にロールを追加することになる。

このGoogle管理のサービスアカウントは編集/削除もできるようになっている。これを削除してしまったりすると色々忘れたころにややこしくなるはずなので、すくなくとも消さないほうがよいようだ。

##### 消して大変だったという記事

- [GCPのIAMポリシー周りでドハマりした話 | フューチャー技術ブログ](https://future-architect.github.io/articles/20190708/)


## リソース管理の権限

CloudFunction をデプロイしたり削除したりするためのサービスアカウントとして `service-PROJECT_NUMBER@gcf-admin-robot.iam.gserviceaccount.com` が用意されている。このサービスアカウントをいじってしまうと、たとえばCloudBuildの権限がなかったりするとビルドできなくてデプロイできなくなる。


## ためしに

`appspot.gserviceaccount.com` についている権限を見てみる。

```bash
$ gcloud iam service-accounts list --filter appspot
```

```bash
$ gcloud projects get-iam-policy myproj-123456 \
    --flatten="bindings[].members" \
    --format="table(bindings.role)" \
    --filter="bindings.members:myproj-123456@appspot.gserviceaccount.com"
```

```
ROLE
roles/editor
```

## 参考

- [IAM によるアクセス制御  |  Google Cloud Functions に関するドキュメント](https://cloud.google.com/functions/docs/concepts/iam)
- [google cloud platform - How do I list the roles associated with a gcp service account? - Stack Overflow](https://stackoverflow.com/questions/47006062/how-do-i-list-the-roles-associated-with-a-gcp-service-account)

