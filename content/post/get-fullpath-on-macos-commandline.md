---
title: "MacOSでコマンドラインからファイルのフルパスを取得する"
slug: get-fullpath-on-macos-commandline
date: 2021-03-21T22:37:46+09:00
draft: false
author: sakamossan
---

`greadlink -f` が一番簡単だった 

```bash
$ greadlink -f ./prisma/_.sql
/Users/akira/.ghq/git/you/_.sql
```

## 参考

- [bash で ファイルの絶対パスを得る - Qiita](https://qiita.com/katoy/items/c0d9ff8aff59efa8fcbb)
