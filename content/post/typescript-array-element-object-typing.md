---
title: "TypeScriptで、「この配列の要素がキーになってるオブジェクト」という型を定義する"
slug: typescript-array-element-object-typing
date: 2020-10-28T12:41:48+09:00
draft: false
author: sakamossan
---

こんな感じでできる

```ts
const columns = ["id", "name", "created"] as const;
type Column = typeof columns[number]; // type Column = "id" | "name" | "created"
type Obj = { [F in Column]: string };
```

`typeof columns[number]` がミソ

- [What means typeof Array[number] in Typescript? - Stack Overflow](https://stackoverflow.com/questions/59541521/what-means-typeof-arraynumber-in-typescript)
