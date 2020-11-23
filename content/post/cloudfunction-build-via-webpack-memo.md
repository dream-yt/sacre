---
title: "Firebase Cloudfunction のデプロイに webpack を使ってビルドしようとするメモ"
slug: cloudfunction-build-via-webpack-memo
date: 2020-05-31T19:03:18+09:00
draft: false
author: sakamossan
---

次のような理由で Cloudfunction のビルドに webpack が使いたくなった

- jsonファイルを require したい
- sqlファイルを raw-loader で require したい

最終的に webpack は不要にしたが、調べたことをメモしておく


## どこにビルド結果を出せばよいか

`firebase init` を TypeScript でつくったプロジェクトだと、ソースコードのビルドは tsc コマンドになっている

```console
$ cat firebase.json
{
  "functions": {
    "predeploy": "npm --prefix \"$RESOURCE_DIR\" run build"
  }
}
```

```console
$ cat functions/package.json | jq .scripts
{
  "build": "tsc",
  "serve": "npm run build && firebase serve --only functions",
  "shell": "npm run build && firebase functions:shell",
  "start": "npm run shell",
  "deploy": "firebase deploy --only functions",
  "logs": "firebase functions:log"
}
```

- tsconfig によるとtscの出力は lib/index.js となり
- package.json#main の設定では、その lib/index.js が指定されている

```console
$ cat tsconfig.json | grep outDir
    "outDir": "lib",
```

```console
$ cat ./package.json | jq . | grep main
  "main": "lib/index.js",
```

この設定だと CloudFunction は lib/index.js を参照することになる

> In order to determine which module to load, Cloud Functions uses the main field in your package.json file. If the main field is not specified, Cloud Functions loads code from index.js.

- [Writing Cloud Functions  |  Cloud Functions Documentation  |  Google Cloud](https://cloud.google.com/functions/docs/writing#structuring_source_code)


## ビルド結果をどの形式で出すか

package.json#main で指定したモジュールを require されることになるので、それができる形式でビルドする必要がある

> For the Node.js runtimes, your function's source code must be exported from a Node.js module, which Cloud Functions loads using a require() call. 

- [Writing Cloud Functions  |  Cloud Functions Documentation  |  Google Cloud](https://cloud.google.com/functions/docs/writing#structuring_source_code)

### webpack.config.js#output

webpack.config.js#output をこんな感じにする

```js
  output: {
    libraryTarget: 'commonjs2',
    filename: 'index.js',
    path: path.resolve(__dirname, 'lib'),
  },
```

`filename`, `path` はビルド結果を出力するパス。 lib/index.js に出力する必要があるのでそのように設定する

`libraryTarget` はビルド結果の実装をどのように export するかを指定する項目。今回はnodejsランタイム上で require されるので export したものを `module.exports` に代入してくれる `commonjs2` を選ぶ

- [Output | webpack](https://webpack.js.org/configuration/output/#outputlibrarytarget)

