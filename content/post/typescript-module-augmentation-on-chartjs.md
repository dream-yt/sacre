---
title: "npmパッケージの提供する型定義が不十分な時に Merging Interface で補足する"
slug: typescript-module-augmentation-on-chartjs
date: 2022-01-12T16:51:50+09:00
draft: false
author: sakamossan
---

## 経緯

`chart.js` を React から扱うためのパッケージである `react-chartjs-2` を使っている。型定義もついていて、`chart.js` の細かいオプションがエディタで補完できるようになる。

なお、`react-chartjs-2` は内部的に `chart.js` が提供する型定義をそのままユーザに提供しているので「`react-chartjs-2` のBarコンポーネントの引数の方は `chart.js` に記述されている」という状態になる。


## 問題

- Barコンポーネントのオプションの一部で型定義がついていないものがあった
    - `BarControllerDatasetOptions` に `column` などが定義されていない
- 必要なオプションなのだが、元の型定義にないので、オプションを渡そうとすると型エラーになる
    - `'column' does not exist in type 'ChartDataset<"bar", unknown>'`


## 対応

本家に型定義の Pull Request を出してる間に TypeScript の Declaration Merging の機能を使ってオプションの足りないフィールドをとりあえずこちらで勝手に補う。


## 実装

```ts
import "chart.js";
declare module "chart.js" {
  interface BarControllerDatasetOptions {
    column: string;
    lineTension: number;
    fill: boolean;
  }
}
```

`import "chart.js";` してから `declare module "chart.js"` とすることで、`chart.js` の型定義に対してパッチを当てることができる。`Module Augmentation` と言うそうだ。

> Although JavaScript modules do not support merging, you can patch existing objects by importing and then updating them. Let’s look at a toy Observable example:
> This works fine in TypeScript too, but the compiler doesn’t know about Observable.prototype.map. You can use module augmentation to tell the compiler about it:


## 参考

- [merging-interfaces | TypeScript: Documentation - Declaration Merging](https://www.typescriptlang.org/docs/handbook/declaration-merging.html#merging-interfaces)
- [module-augmentation | TypeScript: Documentation - Declaration Merging](https://www.typescriptlang.org/docs/handbook/declaration-merging.html#module-augmentation)

