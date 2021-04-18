---
title: "FirebaseCloudfunction上でPrismaを動かしてCloudSQLProxy経由でデータベースに接続する"
slug: firebase-cloudfunction-prisma-cloudsqlproxy
date: 2021-04-18T17:24:01+09:00
draft: false
author: sakamossan
---

CloudFunction はランタイム上から CloudSQLProxy 経由で MySQL と接続することができるようになっている。

- [Cloud Functions から Cloud SQL への接続  |  Cloud SQL for MySQL  |  Google Cloud](https://cloud.google.com/sql/docs/mysql/connect-functions?hl=ja)

もちろん Firebase の CloudFunctions でもこの機能は使うことができる。

## Cloud SQL Admin API を有効にする

この機能は使用する前に GCP のコンソールで Cloud SQL Admin API を有効にする必要がある。

- [API を有効にする - Google Cloud Platform](https://console.cloud.google.com/flows/enableapi?apiid=sqladmin)

CloudFunction はプロジェクトビルトインのサービスアカウント権限で動作している。

> 関数の実行中、Cloud Functions はサービス アカウント PROJECT_ID@appspot.gserviceaccount.com を ID として使用します。たとえば、Google Cloud クライアント ライブラリを使用して Google Cloud Platform サービスにリクエストを送信するときに、Cloud Functions は自動的にトークンを取得して使用し、サービスの認証を行うことができます。

> デフォルトでは、ランタイム サービス アカウントには編集者のロールが付与され、多くの GCP サービスにアクセスできます。これにより、関数の開発時間は短縮できますが、本番環境で必要以上に権限が付与される可能性があるため、最小限の権限が付与されるように構成する必要があります。

- [関数 ID  |  Google Cloud Functions に関するドキュメント](https://cloud.google.com/functions/docs/securing/function-identity?hl=ja)

もともと強いアクセス権限を持っているサービスアカウントだが、そもそもプロジェクトで有効になっていないAPIにはアクセスできないため、それを有効にする必要がある。

## Prisma でプロキシを使う

Prisma でこのプロキシ経由で MySQL と接続する場合、設定は以下のようになる。

```
DATABASE_URL=mysql://username:password@localhost/dbname?socket=/cloudsql/projname-123456:asia-northeast1:dbname
```

socket のパス名は以下の通り。

> 正しく構成されたら、パス /cloudsql/INSTANCE_CONNECTION_NAME で環境のファイルシステムからアクセスされる Cloud SQL インスタンスの Unix ドメイン ソケットにサービスを接続できます。

> INSTANCE_CONNECTION_NAME は、Google Cloud Console でインスタンスの [概要] ページで確認できます。または、次のコマンドを実行します。
> gcloud sql instances describe [INSTANCE_NAME]。

#### 参考

- [MySQL database connector (Reference) | Prisma Docs](https://www.prisma.io/docs/concepts/database-connectors/mysql)
- [Error in google cloud run connecting with cloud SQL · Issue #1508 · prisma/prisma](https://github.com/prisma/prisma/issues/1508)


## その他

最初に Firebase のプロジェクトと、CloudSQL が別なプロジェクトになっているのを忘れていて軽くハマった。もちろん Cloud SQL Admin API 経由で接続するのだから同じプロジェクト内のインスタンスでないとうまく接続できない。(IAMの権限周りをきちんとすれば接続できるのかもしれないが試していない)
