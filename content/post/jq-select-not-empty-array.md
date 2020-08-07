---
title: "jqである属性(配列)が空じゃないもののみに絞る"
date: 2020-08-06T18:42:29+09:00
draft: false
---

`select` と `length` を使えばよい

```bash
cat data.json | jq 'select(.errors | length > 0)
```

## 参考

- [length](https://stedolan.github.io/jq/manual/#length)
- [select](https://stedolan.github.io/jq/manual/#select)
