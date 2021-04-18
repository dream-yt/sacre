---
title: "FirebaseCloudFunction で環境変数を設定する(.env経由)"
slug: firebase-cloudfunction-dot-env
date: 2021-04-18T16:50:15+09:00
draft: false
author: sakamossan
---

Firebase CloudFunction では通常のOSの環境変数の使用は制限されている。ランタイムに変数を注入したい場合はOSの環境変数ではなく、 Firebase独特の環境変数を使う必要があることになっている。

> サードパーティの API キーや調整可能な設定など、関数の追加構成が必要になることがよくあります。Firebase SDK for Cloud Functions では、プロジェクトのこのタイプのデータを簡単に保存および取得できるように、組み込み環境構成が提供されています

- [環境の構成  |  Firebase](https://firebase.google.com/docs/functions/config-env?hl=ja)

GCPの CloudFunction ではデプロイ時に一緒に環境変数を指示するオプションが存在するがFirebaseの CloudFunction にはそのオプションは存在しない。


### OSの環境変数が使いたい場合

Firebase独特の環境変数はOSの環境変数ではないので、使用するモジュールがOSの環境変数を期待している場合に困ったことになる。たとえばdebugパッケージなどは環境変数に色々な値を設定して使うものなので、こういうのが使いたい時はOSの環境変数が使えないと困る。

- [debug - npm](https://www.npmjs.com/package/debug)

今回の場合だと Prisma を使っており、Prismaはデータベースサーバとの接続情報をOSの環境変数経由で指定することになっているので、OSの環境変数を使う方法はないかなぁということになった。

> It is common to load your database connection URL from an environment variable:

```js
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}
```

- [Prisma schema (Reference) | Prisma Docs](https://www.prisma.io/docs/concepts/components/prisma-schema#manage-env-files-manually)


### なんとかOSの環境変数を使う

ただ、調べたところまったくOSの環境変数が使えないわけではなく、プロセス内で `process.env` にセットすればOSの環境変数を設定することができることになっていた。
dotenvを使ってこんなコードをエントリポイントの先頭に置いておけばOSの環境変数が入った状態で関数を実行できた(PrismaはDBに接続できた)。

```ts
import { config } from 'dotenv';
config({ path: '.env.prod' });
```

- [motdotla/dotenv: Loads environment variables from .env for nodejs projects.](https://github.com/motdotla/dotenv#readme)


