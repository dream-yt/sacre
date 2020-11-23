---
title: "nodejsのコードからtypescriptをrequireする"
slug: ts-node-register-to-call-from-nodejs
date: 2019-10-14T14:01:42+09:00
draft: false
author: sakamossan
---

ts-node/register を使うとできる


## たとえば 

- `scripts/make-index.js` というスクリプトから
- `src/bigquery/index.ts` 内のクラスをrequireする

こんなコードを書くとrequireできる

```js
#!/usr/bin/env node
require("source-map-support").install()
require("ts-node").register()

const { Indexer } = require("../src/bigquery")
Indexer.run()
```

普通にnodejsのスクリプトとして実行できる

```bash
$ chmod +x ./scripts/make-index.js
$ ./scripts/make-index.js
```


## 参考

- [TypeStrong/ts-node: TypeScript execution and REPL for node.js](https://github.com/TypeStrong/ts-node)
- [Is it possible to write the gatsby config in TypeScript? · Issue #1457 · gatsbyjs/gatsby](https://github.com/gatsbyjs/gatsby/issues/1457#issuecomment-381405638)
