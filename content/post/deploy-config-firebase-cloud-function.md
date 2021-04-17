---
title: "FirebaseCloudFunctions のデプロイ設定を書くところ"
slug: deploy-config-firebase-cloud-function
date: 2021-04-17T11:31:49+09:00
draft: false
author: sakamossan
---

こちらの実装がデプロイされる仕組みの部分についてメモ。

- [NestJS を Firebase Cloudfunction 上で動かす](https://blog.n-t.jp/tech/nestjs-firebase-cloudfunction/)

今回の例だとディレクト構成はこのようになっている。

```
$ tree -L 2 ../
../
├── firebase.json
├── public
│   └── index.html
└── server
    ├── README.md
    ├── dist
    ├── node_modules
    ├── package.json
    ├── src
    ├── tsconfig.json
    └── yarn.lock
```

server ディレクトリ配下に CloudFunction 用の TypeScript の実装があるという状態で、`server/package.json` にある npm-scripts を使って Firebase の function が動作するまでの仕組みをメモる。


# firebaseの設定

server ディレクトリに firebase.json は置いていないが、firebase コマンドは上位ディレクトリに firebase.json ファイルを探して、設定を読んでくれる。

今回の例ではこんな設定になっている。

```
$ cat ../firebase.json | jq .functions
{
  "source": "server"
  "predeploy": [
    "npm --prefix \"$RESOURCE_DIR\" run lint",
    "npm --prefix \"$RESOURCE_DIR\" run build"
  ],
}
```

fierbase のデプロイコマンドが発行された時に predeploy に記述されている処理が動いてからコードがアップロードされる。`\"$RESOURCE_DIR\"` の環境変数には source で定義されたディレクトリが入るようだ。なおエミュレータ起動時にはこの処理は動かないので、エミュレータ起動前にコードをビルドする処理を自前で実装して挟み込んでおく必要がある。

### 参考

- [Firebase CLI リファレンス](https://firebase.google.com/docs/cli?hl=ja#hooks)
- [Cloud Functions に TypeScript を使用する  |  Firebase](https://firebase.google.com/docs/functions/typescript?hl=ja#using_an_existing_typescript_project)


# package.json 

firebase では package.json をみている部分がある

- 依存関係のインストール
- nodejsのバージョンはなにを使うか
- プロセスを起動するエントリーポイントがどこか
- preinstall / postinstall の起動

## 依存関係のインストール

firebase ではデプロイ時にFaaSランタイム上で `npm ci` (yarn.lockがあれば `yarn install` ) を発行して依存関係をインストールしてくれる

> 外部の Node.js モジュールも使用できます。Node.js における依存関係は、npm で管理され、package.json というメタデータ ファイルで表現されます。Cloud Functions Node.js ランタイムは通常、npm または yarn を使用したインストールをサポートしています。

> 注: package-lock.json や yarn.lock ファイルがプロジェクト内にある場合は、npm ci や yarn install を使用して依存関係がインストールされる際、そのロックファイルが優先されます。

- [依存関係の扱い  |  Firebase](https://firebase.google.com/docs/functions/handle-dependencies?hl=ja)


## nodejsのバージョンはなにを使うか

engines という項目に設定を入れて指示する。

```bash
$ cat ./package.json | jq .engines
{
  "node": "14"
}
```

> 初期化時に functions/ ディレクトリに作成された package.json ファイルの engines フィールドにバージョンを設定します。

- [関数のデプロイとランタイム オプションを管理する  |  Firebase](https://firebase.google.com/docs/functions/manage-functions?hl=ja#set_nodejs_version)


## プロセスを起動するエントリーポイントがどこか

JavaScript で書かれたプロジェクトだと index.js を参照してくれるのはわかりやすいが、TypeScript で書いている場合などトランスパイルをはさむ必要があるときは、`package.json#main` にトランスパイル後のエントリポイントが置かれる場所を指示する。

```json
$ cat ./package.json | grep -C3 '"main"'
  "engines": {
    "node": "14"
  },
  "main": "dist/index.js",  <<<
  "scripts": {
    "postinstall": "prisma generate",
    "prebuild": "rimraf dist",
```

> "main" を "lib/index.js" に設定します。

- [Cloud Functions に TypeScript を使用する  |  Firebase](https://firebase.google.com/docs/functions/typescript?hl=ja#migrating_an_existing_javascript_project_to_typescript)


## preinstall / postinstall 

`npm ci` や `yarn install` を実行してくれるので、当然 npm-script の preinstall / postinstall も実行される。Firebaseのドキュメントにはわざわざ書かれていなかったが、prisma のデプロイサンプルにて公式が紹介してて知った。

> GCP allows deploying just the project and fetches the modules for the user. To generate the Prisma client, we use the npm postinstall hook. 

- [e2e-tests/README.md at 5a0ac0b97ad30dd071c9e669d1a0f85074ec7d4a · prisma/e2e-tests](https://github.com/prisma/e2e-tests/blob/5a0ac0b97ad30dd071c9e669d1a0f85074ec7d4a/platforms/gcp-functions/README.md)

