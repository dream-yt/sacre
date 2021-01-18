---
title: "jqで正規表現を使ってフィルタする"
slug: jq-regexp-filter
date: 2021-01-18T14:33:20+09:00
draft: false
author: sakamossan
---

`select` と `test` をつかってフィルタする

## 例

こんなjsonがあったとして。

```json
$ cat /tmp/_
{
  "monitors": [
    {
      "id": "mysql",
      "name": "mysql-freeable_memory"
    },
    {
      "id": "redis10",
      "name": "redis10-freeable_memory"
    },
    {
      "id": "redis11",
      "name": "redis11-freeable_memory"
    }
  ]
}
```

たとえば monitorsオブジェクトのname属性を正規表現で絞って数値を見たいとき。

```json
$ cat /tmp/_ | jq '.monitors[] | select(.name | test("^redis.+freeable_memory"))'
{
  "id": "redis10",
  "name": "redis10-freeable_memory"
}
{
  "id": "redis11",
  "name": "redis11-freeable_memory"
}
```


## 参考

- [Regular expressions (PCRE) | jq Manual (development version) ](https://stedolan.github.io/jq/manual/#RegularexpressionsPCRE)
