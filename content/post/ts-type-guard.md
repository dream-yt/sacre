---
title: "TypeScript の Type Guard を使う"
date: 2019-11-01T08:03:40+09:00
draft: false
author: sakamossan
---

typescriptでは型をチェックするような分岐を書くことができる  
その分岐の中だと「この変数はこの型」というのをコンパイラ/エディタが認識してくれる

型をチェックできる条件の書き方は、返り値の型のところに工夫をすればよい

## 例

- 型を `pet is Fish` と書いて
- booleanを返す関数を書く

```ts
function isFish(pet: Fish | Bird): pet is Fish {
    return (pet as Fish).swim !== undefined;
}
```

こうすると isFish が true だった場合の分岐で型推論が効くようになる


```ts
if (isFish(obj) {
  ...  // ここは型推論が効く
})
```


## 参考

- [Advanced Types · TypeScript](https://www.typescriptlang.org/docs/handbook/advanced-types.html#user-defined-type-guards)
- [TypeScript の Type Guard を使ってキャストいらず - Qiita](https://qiita.com/propella/items/33433278497f290ceadb)

