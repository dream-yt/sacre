---
title: "jq変形 {配列 => IDをキーとするオブジェクト}"
date: 2019-07-03T15:30:19+09:00
draft: false
---

こんな配列を

```json
[
  {"id": "123", "name": "abc"},
  {"id": "456", "name": "qwe"}
]
```

こうしたい

```json
{
  "123": {"id": "123", "name": "abc"},
  "456": {"id": "456", "name": "qwe"}
}
```

`add` を使うとできる

```
$ pbpaste | jq '{ (.id): . } | [ . ] | add'
{
  "123": {
    "id": "123",
    "name": "abc"
  },
  "456": {
    "id": "456",
    "name": "qwe"
  }
}
```


### add

通常は足し算や文字列結合に使われるが、
オブジェクトの配列に適用すると、それぞれの要素をマージしたオブジェクトができる

- [QUESTION: A way to concatenate input objects into one · Issue #70 · stedolan/jq](https://github.com/stedolan/jq/issues/70)

```json
[
  { "123": {"id": "123", "name": "abc"} }
  { "456": {"id": "456", "name": "qwe"} }
]
```

↓ こうなるイメージ

```json
{
  "123": {"id": "123", "name": "abc"},
  "456": {"id": "456", "name": "qwe"}
}
```
