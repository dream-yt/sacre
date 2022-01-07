---
title: "TypeScriptでパッケージ(JQueryDataTable)がexportしていない型を使う"
slug: extract-not-exported-package-type-definition
date: 2022-01-07T17:30:22+09:00
draft: false
author: sakamossan
---

jQueryDataTable を使っているのだが、公式の型定義はexportしている型があまりない。

- [DefinitelyTyped/index.d.ts at master · DefinitelyTyped/DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped/blob/master/types/datatables.net/index.d.ts)

このパッケージはオプションでいろいろな設定ができるようになっているのだが、色々できるだけあって複雑で、そのオプションの引数の型を調べるのにドキュメントとにらめっこする羽目になっている。オプションの引数の型定義が得られればその手間もなくなって嬉しい。


## やりかた

このようにすると、オプションの引数の型定義を取り出すことができた。

```ts
import jQueryDataTable from "datatables.net";
type DataTableSettings = ConstructorParameters<typeof jQueryDataTable>[0]
```

わかりやすく分解するとこうなる。

```ts
import jQueryDataTable from "datatables.net";
// 値であるjQueryDataTableの型を取り出す
type DataTableConstructor = typeof jQueryDataTable;
// jQueryDataTableはコンストラクタなので、newに対する引数を取り出す
type DataTableConstructorParameter = ConstructorParameters<DataTableConstructor>;
// ConstructorParameters は引数の型を配列で返すので、コンストラクタの1つ目の引数取り出す
type DataTableSettings = DataTableConstructorParameter[0]
```


## 参考

- [TypeScript/lib.es5.d.ts at v3.3.1 · microsoft/TypeScript](https://github.com/Microsoft/TypeScript/blob/v3.3.1/lib/lib.es5.d.ts#L1476-L1479)
- [DefinitelyTyped/datatables.net at master · DefinitelyTyped/DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped/blob/master/types/datatables.net/index.d.ts#L1220)
- [TypeScript. How to use not exported type definitions? - Stack Overflow](https://stackoverflow.com/questions/46754984/typescript-how-to-use-not-exported-type-definitions)
- [How to get argument types from function in Typescript - Stack Overflow](https://stackoverflow.com/questions/51851677/how-to-get-argument-types-from-function-in-typescript)
