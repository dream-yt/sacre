---
title: "jqである属性(配列)が空じゃないもののみに絞る"
slug: jq-select-not-empty-array
date: 2020-08-06T18:42:29+09:00
draft: false
author: sakamossan
---

`select` と `length` を使えばよい

```bash
cat data.json | jq 'select(.errors | length > 0)
```

## 参考

- [length](https://stedolan.github.io/jq/manual/#length)
- [select](https://stedolan.github.io/jq/manual/#select)
