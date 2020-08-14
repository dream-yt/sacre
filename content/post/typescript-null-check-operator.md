---
title: "typescriptでのnullチェック"
date: 2019-06-30T13:59:54+09:00
draft: false
author: sakamossan
---

基本的にはイコール2つの演算子でチェックすれば
undefinedとnullのどちらかであればtrueになる

> `== null`

## 例

```ts
$ ts-node
> const v = {a: 1, c: null}
undefined
```

### イコールふたつ

nullとundefinedを区別しなくて楽

```ts
> v['b'] == null
true
> v['c'] == null
true
```

### イコールみっつだと厳格

```ts
> v['c'] === null
true
> v['b'] === null
false
```


## その他

宣言していない変数についても書いてあるが、これは特殊なコードになってる場合
普通のコードではイコール2つの演算子でチェックすればよい

- [Null vs. Undefined - TypeScript Deep Dive 日本語版](https://typescript-jp.gitbook.io/deep-dive/recap/null-undefined)
