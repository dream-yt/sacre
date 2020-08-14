---
title: "firebase上でtypescriptで書かれたnextjsを動かす"
date: 2019-07-18T09:21:04+09:00
draft: false
author: sakamossan
---

こちらのexampleを動かしながらデプロイまでの流れをみる

- [next.js/examples/with-firebase-hosting at master · zeit/next.js](https://github.com/zeit/next.js/tree/master/examples/with-firebase-hosting)

できればtypescriptで開発したいので、それでどのへんをいじればいいのかも確認する


## deploy

predeployで以下のコマンドが走る

```bash
npm run build-public
npm run build-funcs
npm run build-app
npm run copy-deps
```

これはそれぞれpackage.jsonでの定義がこうなっている

```bash
# publicディレクトリには画像などの静的ファイルを置く
cpx "src/public/**/*.*" "dist/public" -C
# cloud function のエントリポイントになる処理をbuild
babel "src/functions" --out-dir "dist/functions"
# next.config.jsによればbuild先はdist/functions/next
# exports.next している index.js はここのビルド結果を使っている
next build "src/app/"
# cloud function のデプロイに必要なファイルをdist配下へ
cpx "*{package.json,package-lock.json,yarn.lock}" "dist/functions" -C
```

### deployがやっていること

`next build` と `babel` の2つのビルドコマンドを発行してるのが斬新

- `dist/` 配下にcloudfunctionへアップロードするコードを集約
  - firebase.json
    - hosting: `dist/public`
    - functions: `dist/functions`
- `npm run deploy` で `firebase deploy` を実行
    - public (静的ファイル) と functions (WebAPI) の両方をアップロード

### nextとcloudfunction関数のつなぎこみ

- `dist/functions/index.js` が cloud function から参照されるファイル
- `dist/functions/index.js` が `dist/functions/next` 配下をloadしている

```js
var app = next({
  dev,
  conf: { distDir: `${path.relative(process.cwd(), __dirname)}/next` }
})
```


### cpx

cpxはrsync的なことをしてくれるコマンド
package.jsonで使われている

```bash
cpx "src/public/**/*.*" "dist/public" -C
```

`-C` オプションはコピーする前に`dist/public`の中身を空にするもの

> -C, --clean               Clean files that matches <source> like pattern in
>                              <dest> directory before the first copying.


### rimraf

`rm -rf` と同じことをしてくれる

この辺が便利なようだ

- windowsでも動く
- 対象ファイルがなくてもエラーにならない


## .firebaserc

`project-name`って書いてあるけど入れるのはprojectId

> "default": "<project-name-here>"

```bash
$ firebase list
┌─────────┬───────────────────────┬─────────────┐
│ Name    │ Project ID / Instance │ Permissions │
├─────────┼───────────────────────┼─────────────┤
│ testpjt │ testpjt-534512        │ Owner       │
└─────────┴───────────────────────┴─────────────┘
```


# TypeScript に書き換える

~~このあたりを書き換えたらよさそう~~

> "build-funcs": "babel \"src/functions\" --out-dir \"dist/functions\"",

nextがbabelを使う設定になってるようなので、ここはそのままにしてbabelでtypescriptをコンパイルする方式にした。babelの設定を書き換えている

```json
{
  "presets": [
    "next/babel",
    "@babel/preset-typescript"
  ]
}
```

babelでtypescriptをコンパイルしているので、ビルド時の型チェックなどは提供されない

## 必要だったpackage

この辺のインストールが必要だった

```
yarn add @types/react @babel/preset-typescript --dev
```

- `@types/react` はreactの型定義
- `@babel/preset-typescript` はbabelでtsをコンパイルするためのpreset
    - ビルド時に型チェックとかはしてくれる


## ファイルのリネーム

こんな感じで一括リネーム

```bash
$ find ./src -name '*.js' -type f \
    | perl -wnlE '/(\S+).js/ and say "$1.js $1.tsx"' \
    | xargs -n2 mv
```

## tsconfig.json

babel越しにビルドするとtsconfigが自動で書き換えられる

> The following changes are being made to your tsconfig.json file:
>  - compilerOptions.strict to be suggested value: false (this can be changed)
>  - compilerOptions.esModuleInterop must be true (requirement for babel)
>  - compilerOptions.resolveJsonModule must be true

babelに都合がよいような設定になる

---

ここまでで

- firebase cloud function 上で
- typescript で書かれた
- nextjs を動かす

が出来た

