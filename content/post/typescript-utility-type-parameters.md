---
title: "TypeScript で、関数の引数の型をtypeとして宣言したい場合"
slug: typescript-utility-type-parameters
date: 2021-04-24T18:38:44+09:00
draft: false
author: sakamossan
---

Utility Type の `Parameters` を `typeof` と一緒に使えばよい。

```ts
const f = ({ a, b }) => {};
type FArg = Parameters<typeof f>;  //  type FArg = [{ a: any; b: any; }]
```

公式ドキュメントで紹介されている。

- [TypeScript: Documentation - Utility Types](https://www.typescriptlang.org/docs/handbook/utility-types.html#parameterstype)
