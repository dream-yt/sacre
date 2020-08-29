---
title: "TypeScriptのモジュール読み込みについて"
date: 2020-08-28T18:45:04+09:00
draft: true
author: sakamossan
---

tscが `import './foo'` で `foo` を探す順番
なお、探すファイルの拡張子は `.ts`, `.d.ts`, `.js`

1. `./foo.ts`
1. `./foo/index.ts`
1. `./foo/package.json#types` で指定されてるファイル
1. `./foo/package.json#main` で指定されてるファイル

## package.json#module

これは依存関係を静的に解決する時に使われるものでtscはこれを参照しない。
ここに定義されるのはESMで記述されたjsファイルである。

webpackなどのtree-shakingを行うトランスパイラはmainでなくこちらを使おうとする


## 参考

- 
