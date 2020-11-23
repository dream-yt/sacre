---
title: "firebaseでスケジュール(cron)実行"
slug: firebase-cloudfunctions-cron
date: 2019-11-09T17:14:52+09:00
draft: false
author: sakamossan
---

まず、事前にfirebaseのコンソール画面で `リソースロケーション` を選ぶ必要がある

- コンソール
  - `Project Overview` の隣の ⚙ マーク
    - `Google Cloud Platform（GCP）リソース ロケーション` から変更

これをどれか選択しておかないと関数のデプロイ時に以下のようなログがでる

> Error: Cloud resource location is not set for this project but scheduled functions requires it. Please see this documentation for more details: https://firebase.google.com/docs/projects/locations.


## サンプルコード

こんな感じで日本時間の17時に毎分動く関数が設定できる

```ts
import * as functions from 'firebase-functions';

exports.scheduledFunction = functions
  .region('asia-northeast1')
  .pubsub.schedule('* 17 * * *')
  .timeZone('Asia/Tokyo')
  .onRun(context => {
    console.log(context);
    return null;
  });
```

#### 余談(console.dirについて)

実行時のログを見るのにはこんなコマンドを使う

```bash
$ firebase functions:log --token "$FIREBASE_TOKEN"
```

なお、`console.dir` を使うとログは見られなかった

CloudFunction で後から見れるログを吐くには `console.log`, `console.error` のどちらかを使う必要があった

- [ログの書き込みと表示  |  Cloud Functions のドキュメント  |  Google Cloud](https://cloud.google.com/functions/docs/monitoring/logging)
