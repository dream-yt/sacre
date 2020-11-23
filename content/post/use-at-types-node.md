---
title: "@types/nodeを使う"
slug: use-at-types-node
date: 2019-10-12T13:05:11+09:00
draft: false
author: sakamossan
---

@types/nodeをいれておくと  
fsなどnodeのデフォルトのモジュールで型の補完がきくようになる

- [DefinitelyTyped/types/node at master · DefinitelyTyped/DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped/tree/master/types/node)

@types/node のバージョンは node のバージョンと対応している

> Simply, the major version and minor version tagged in the semver string of @types/node is exactly corresponding to the node's version.

index.d.ts を見てもそんなことが書いてある

```console
$ head -3 ./node_modules/@types/node/index.d.ts
// Type definitions for Node.js 10.14
// Project: http://nodejs.org/
// Definitions by: Microsoft TypeScript <https://github.com/Microsoft>
```

なのでnodeのバージョンと近いものを入れておく  
(バージョンによっては@types/nodeがなかったりする)

```bash
$ node --version
v10.15.0
```

```bash
$ yarn add --dev @types/node@10.14.21
```


## 参考

- [typescript - Relationship between the version of node.js and the version of @types/node - Stack Overflow](https://stackoverflow.com/questions/42035263/relationship-between-the-version-of-node-js-and-the-version-of-types-node)
