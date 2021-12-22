---
title: "Cloud Function (非Firebase) に TypeScript のコードをデプロイする"
slug: cloudfunction-typescript-deploy-notfirebase
date: 2021-12-22T12:03:30+09:00
draft: false
author: sakamossan
---

デプロイの要件はひととおりドキュメントに書いてあるので、それを満たすように tsconfig やデプロイスクリプトを作ることになる。

- [Cloud Functions のデプロイ  |  Google Cloud Functions に関するドキュメント](https://cloud.google.com/functions/docs/deploying)
- [gcloud functions deploy  |  Cloud SDK Documentation  |  Google Cloud](https://cloud.google.com/sdk/gcloud/reference/functions/deploy)


## デプロイの要件

要件上では、最低限この2つのファイルがあればデプロイができる。

- index.js
- package.json 

index.js に関数を実装して、それが `module.exports` なり `export` されていれば、その処理がイベント発生時に実行される。

```ts
export const myFunc = () => {...};
```


## 依存パッケージ

package.json に書いてある依存パッケージはGCP側がインストールしてくれる。

> 関数の依存関係を指定するには、package.json ファイルにその依存関係を追加します。

- [Node.js での依存関係の指定  |  Google Cloud Functions に関するドキュメント](https://cloud.google.com/functions/docs/writing/specifying-dependencies-nodejs)


## ファイル名の規約

`gloud function` コマンドは指定されたディレクトリの `index.js` か `function.js` という名前のファイルを探して、それをデプロイしてくれるようになっている。

> Cloud Functions will look for files with specific names for deployable functions. For Node.js, these filenames are index.js or function.js.

- [gcloud functions deploy  |  Cloud SDK Documentation  |  Google Cloud](https://cloud.google.com/sdk/gcloud/reference/functions/deploy#--source)

すべてを1ファイルにバンドルする必要はないが、エントリポイントとして最初に読み込まれるファイル名は規約どおり`index.js` などにしておくか、`--source` オプションで指定することになる。


## ESM

ESM で記述されたコードをデプロイしたい場合は package.json に `"type": "module"` と記述すればよいようだ。

> Cloud Functions の関数内で ESM を使用するには、package.json 内で "type": "module" を宣言する必要があります。

- [Node.js ランタイム  |  Google Cloud Functions に関するドキュメント](https://cloud.google.com/functions/docs/concepts/nodejs-runtime)

TypeScript で書いているので今回はあんまり気にする必要はない。


# 例 

最小限のデプロイをするためのコード例

## ./src/index.ts

- httpエンドポイントをつくるときは `functions-framework` の型定義が便利。
- `export const {{関数名}}` とすれば、それを gcloud が拾ってくれる。

```ts
import type { HttpFunction } from '@google-cloud/functions-framework/build/src/functions';
export const sendSlack: HttpFunction = (req, res) => {...};
```

## ./package.json

- 先述のESMの設定などはここに。他には依存パッケージが書いてあればよい。

```js
{
  "type": "module",
  "dependencies": {
    "nodemailer": "^6.7.2"
  }
}
```

## tsconfig.json

必要そうなところだけ抜粋。

```json
{
  "compilerOptions": {
    // ESMでハマるのが面倒だったのでjsはcommonjsで出力
    "module": "commonjs",  
    // ここで指定した ディレクトリの中身を Cloud Function にアップロードする
    "outDir": "./dist",
  },
}
```

## ./deploy.sh

```bash
#!/usr/bin/env bash
set -euxo pipefail
cd $(dirname $0)

# デプロイされるディレクトリを掃除
rm -rf ./dist/*
# ./src に書かれたコードを ./dist 配下に出力
npx tsc
# デプロイディレクトリに package.json が必要なのでコピー
cp ./package.json ./dist/

# デプロイ先の環境があっているように念の為設定
gcloud config set account xxxxxxxx@gmail.com
gcloud config set project macro-fucker-xxxxxxx

gcloud functions deploy \
    # デプロイする CloudFunction の名前を定義
    sendSlack \
    # デプロイディレクトリの指定
    --source=./dist \
    # デフォルトだとusにできてしまうのでregionを設定
    --region=asia-northeast1 \
    # デプロイされる関数名 (index.js 内に定義されているもの)
    --entry-point=sendSlack \
    # http エンドポイントを作るためのオプション
    --trigger-http \
    # http エンドポイントに認証をかけない(オープンにする)ためのオプション
    --allow-unauthenticated \
    # ランタイムを指定
    --runtime=nodejs14 \
```
