---
title: "jsファイルの容量削減 lodash/jQuery"
slug: diet-js-bundle-file
date: 2020-07-25T00:01:24+09:00
draft: false
author: sakamossan
---

webpackの設定がよくなかったのか、生成したバンドルjsファイルが重かったので若干雑な感じで軽くした


### lodashは全部読み込むと結構重い

lodashは全部ビルドにふくめてしまうと500KBとかになっていてかなり重い

一部の関数しか使っていないのなら、こんな感じでロードするコードを減らすことができる。これはドキュメントにも書いてある方法

```ts
import { pull } from 'lodash';
```

```ts
import pull from 'lodash/pull';
```


### ほとんと機能を使ってないjQueryが重い

`getElementById` とか `addEventListene` とか書きたくないので jQuery を使ったのだが、jQueryも意外と300KB弱あったので代替として `cash` を使ってみた

- [fabiospampinato/cash: An absurdly small jQuery alternative for modern browsers.](https://github.com/fabiospampinato/cash)

これはきちんと動いたのでよかったのだが、TypeScript対応がきちんとされていてその点だけで本家のjQuery使うならこっちの方が全然良いなという感じだった


## 雑にライブラリごとのファイル容量を確認する

webpackがバンドルするファイル容量を確認する方法として `webpack-bundle-analyzer` があるが、そこまで依存ライブラリが多くない場合は `--display-modules` オプションをつければ一応ライブラリごとの容量が出力されるようになる

出力はこんな感じだが、依存が少なければ見れないこともない

```console
$ npx webpack --display-modules
Hash: 705e7db395ef48091f13
Version: webpack 4.43.0
Time: 2545ms
Built at: 2020-07-25 0:06:12
   Asset     Size  Chunks             Chunk Names
index.js  238 KiB    main  [emitted]  main
Entrypoint main = index.js
[./node_modules/brownies/brownies.min.js] 9.02 KiB {main} [built]
[./node_modules/cash-dom/dist/cash.js] 34.8 KiB {main} [built]
[./node_modules/css-loader/dist/cjs.js!./node_modules/sass-loader/dist/cjs.js!./src/browser/index.scss] 547 bytes {main} [built]
[./node_modules/css-loader/dist/runtime/api.js] 2.46 KiB {main} [built]
[./node_modules/lodash/_Symbol.js] 118 bytes {main} [built]
[./node_modules/lodash/_apply.js] 714 bytes {main} [built]
[./node_modules/lodash/_arrayMap.js] 556 bytes {main} [built]
[./node_modules/lodash/_baseFindIndex.js] 766 bytes {main} [built]
[./node_modules/lodash/_baseGetTag.js] 792 bytes {main} [built]
[./node_modules/lodash/_baseIndexOf.js] 659 bytes {main} [built]
[./node_modules/lodash/_baseIndexOfWith.js] 660 bytes {main} [built]
[./node_modules/lodash/_baseIsNaN.js] 296 bytes {main} [built]
[./node_modules/lodash/_baseIsNative.js] 1.38 KiB {main} [built]
[./node_modules/lodash/_basePullAll.js] 1.42 KiB {main} [built]
[./node_modules/lodash/_baseRest.js] 559 bytes {main} [built]
[./node_modules/lodash/_baseSetToString.js] 641 bytes {main} [built]
[./node_modules/lodash/_baseUnary.js] 332 bytes {main} [built]
[./node_modules/lodash/_copyArray.js] 454 bytes {main} [built]
[./node_modules/lodash/_coreJsData.js] 157 bytes {main} [built]
[./node_modules/lodash/_defineProperty.js] 233 bytes {main} [built]
[./node_modules/lodash/_freeGlobal.js] 173 bytes {main} [built]
[./node_modules/lodash/_getNative.js] 483 bytes {main} [built]
[./node_modules/lodash/_getRawTag.js] 1.11 KiB {main} [built]
[./node_modules/lodash/_getValue.js] 325 bytes {main} [built]
[./node_modules/lodash/_isMasked.js] 564 bytes {main} [built]
[./node_modules/lodash/_objectToString.js] 565 bytes {main} [built]
[./node_modules/lodash/_overRest.js] 1.07 KiB {main} [built]
[./node_modules/lodash/_root.js] 300 bytes {main} [built]
[./node_modules/lodash/_setToString.js] 392 bytes {main} [built]
[./node_modules/lodash/_shortOut.js] 941 bytes {main} [built]
[./node_modules/lodash/_strictIndexOf.js] 600 bytes {main} [built]
[./node_modules/lodash/_toSource.js] 556 bytes {main} [built]
[./node_modules/lodash/constant.js] 528 bytes {main} [built]
[./node_modules/lodash/identity.js] 370 bytes {main} [built]
[./node_modules/lodash/isFunction.js] 993 bytes {main} [built]
[./node_modules/lodash/isObject.js] 733 bytes {main} [built]
[./node_modules/lodash/pull.js] 758 bytes {main} [built]
[./node_modules/lodash/pullAll.js] 710 bytes {main} [built]
[./node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js] 6.64 KiB {main} [built]
[./node_modules/webpack/buildin/global.js] (webpack)/buildin/global.js 472 bytes {main} [built]
[./src/browser/index.scss] 569 bytes {main} [built]
[./src/browser/index.ts] 3.6 KiB {main} [built]
```
