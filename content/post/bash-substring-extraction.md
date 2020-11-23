---
title: "bashの変数から文字列を取り出す"
slug: bash-substring-extraction
date: 2020-06-25T12:22:41+09:00
draft: false
author: sakamossan
---

以下のような記法で変数から部分文字列を取り出すことができる

- `${FOO%...}`
- `${FOO#...}`

[string - Extract substring in Bash - Stack Overflow](https://stackoverflow.com/questions/428109/extract-substring-in-bash)

## 例

- `ui/src/js/test/tag.js` という文字列から 
  1. `test/tag.js` という文字列を取り出す場合
  2. `ui/src/` という文字列を取り出す場合

取り出したい文字列を書くのではなく、除去したい文字列を書くことになる

- 文字列の文頭から文字列を除去するのは `#`
- 文末から除去する場合は `%`


### `test/tag.js` を取り出す

`ui/src/js/test/tag.js` の左側から `ui/src/js/` を探して除去

```bash
readonly FOO=ui/src/js/test/tag.js
echo ${FOO#ui/src/js/}
```


### `ui/src/` を取り出す

`ui/src/js/test/tag.js` の右側から `js/test/tag.js` を探して除去

```bash
readonly FOO=ui/src/js/test/tag.js
echo ${FOO%/js/test/tag.js}
```
