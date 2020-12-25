---
title: "create-react-app と firebase の環境構築"
slug: firebase-and-create-react-app
date: 2020-12-25T18:53:17+09:00
draft: false
author: sakamossan
--- 

公式で案内されている手順だと先にCRAをやることになる。

- [Deployment | Create React App](https://create-react-app.dev/docs/deployment/#firebase)

### CRA

```bash
$ npx create-react-app . --typescript --use-npm
```


### Firebaseのconsoleでいろいろ操作

先にいろいろつくらないと `firebase init` がコケる

- プロジェクトの作成
- リージョンの設定
- Functionsを使うならクレカを登録
- FireStoreを使うならデータベースを作成


### firebase init

- [Firebase CLI リファレンス](https://firebase.google.com/docs/cli?hl=ja#windows-npm)

```bash
$ firebase login
$ firebaee init
```
