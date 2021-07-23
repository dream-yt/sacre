---
title: "P Map Err Require Esm"
slug: p-map-err-require-esm
date: 2021-07-23T23:51:53+09:00
draft: false
author: sakamossan
---

`p-map` でエラーが出るようになった。

```console
⚠  Error [ERR_REQUIRE_ESM]: Must use import to load ES Module: /Users//node_modules/p-map/index.js
require() of ES modules is not supported.
require() of /Users//node_modules/p-map/index.js from /Users//lib/job/scrape-work-status/worker.js is an ES module file as it is a .js file whose nearest parent package.json contains "type": "module" which defines all .js files in that package scope as ES modules.
Instead rename index.js to end in .cjs, change
```

issueになっているが、とてもそっけない

- [Must use import to load ES Module · Issue #35 · sindresorhus/p-map](https://github.com/sindresorhus/p-map/issues/35)

> Please read the release notes.

リリースノートに書いてあった。 `Please read this` とのこと。

- [Releases · sindresorhus/p-map](https://github.com/sindresorhus/p-map/releases)

> Breaking
> This package is now pure ESM. Please read this.


## 対応

これ自体は悪い決断ではないと思うが、パッケージの利用者にはtree-shakingとか以外には大きなメリットはないはず。
そもそもとてもシンプルなライブラリなので機能追加もない。過去のバージョンにて利用を続ければよい。

```console
yarn add p-map@4
```


## 参考

- [Comparing v4.0.0...v5.0.0 · sindresorhus/p-map](https://github.com/sindresorhus/p-map/compare/v4.0.0...v5.0.0)
- [Pure ESM package](https://gist.github.com/sindresorhus/a39789f98801d908bbc7ff3ecc99d99c)
