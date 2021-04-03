---
title: "NestJS を Firebase Cloudfunction 上で動かす"
slug: nestjs-firebase-cloudfunction
date: 2021-04-04T00:06:54+09:00
draft: false
author: sakamossan
---

NestJS を Firebase Cloudfunction 上で動かした時のメモ。公式のリポジトリで example とか issue を探したけどパッと出てこなかったので、野良の実装を参考にしてやっている。

## firebaseの準備

```bash
$ npm install -g firebase-tools
$ firebase login
$ firebase init  # ビルドは typescript で生成するように
$ rm -rf ./functions # この生成されたコードは消してしまってよい
$ (cd my-nestapp; npm install firebase-admin firebase-functions)
```

firebase.json を変更して firebase deploy が参照するパスを変更する

- [Manage functions deployment and runtime options  |  Firebase](https://firebase.google.com/docs/functions/manage-functions)

```diff
--- a/firebase.json
+++ b/firebase.json
@@ -1,5 +1,6 @@
 {
   "functions": {
+    "source": "my-nestapp",
     "predeploy": [
```

typescript/firebase の仕様に沿うよう `package.json#main` も変更。

```diff
--- a/package.json
+++ b/package.json
@@ -8,6 +8,7 @@
   "engines": {
     "node": "14"
   },
+  "main": "dist/index.js",
   "scripts": {
```

変更したパスに index.ts を配備。
この例だと `./my-nestapp/src/index.ts` となる。

```ts
import { NestFactory } from '@nestjs/core';
import { ExpressAdapter } from '@nestjs/platform-express';
import * as express from 'express';
import * as functions from 'firebase-functions';
import { AppModule } from './app.module';

const server = express();

const promiseApplicationReady = NestFactory.create(
  AppModule,
  new ExpressAdapter(server),
).then((app) => app.init());

export const api = functions
  .region('asia-northeast1')
  .https.onRequest(async (...args) => {
    // https://qiita.com/chelproc/items/37ed6ed27ee599b586bf
    await promiseApplicationReady;
    server(...args);
  });
```

動作確認に `firebase emulators` を使う。
ちゃんとレスポンスが返ってくるならここまではOK。

```bash
$ npx firebase emulators:start --only functions
$ curl -I http://localhost:5001/my-nestapp/us-central1/api/myitem
```

firebaseのコンソールで支払いをBlazeに変更したらデプロイ。

```bash
$ (cd my-nestapp/; npm run build; cd ../; firebase deploy --only functions)
```

#### 参考

- [nest-cloud-functions/index.ts at master · fireship-io/nest-cloud-functions](https://github.com/fireship-io/nest-cloud-functions/blob/master/B-functions/functions/src/index.ts)
- [NestJS をFirebase Functions で動かすための環境構築について - Qiita](https://qiita.com/0622okakyo/items/d69209b8b01c474c36be)
- [Nest.jsのアプリケーションをCloud Functionsにデプロイする - Qiita](https://qiita.com/chelproc/items/37ed6ed27ee599b586bf)
