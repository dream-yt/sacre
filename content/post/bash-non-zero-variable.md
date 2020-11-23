---
title: "シェルスクリプトで変数が未定義かを確認する"
slug: bash-non-zero-variable
date: 2020-02-12T09:06:11+09:00
draft: false
author: sakamossan
---

毎回忘れるのでメモ

`-n` で判定できる。逆は `-z`。
正確には値のlengthがnon-zeroかという判定をしている

## main.sh

```bash
#!/bin/bash

[ -n "$ONE" ] && echo "ONE is non-zero"
[ -z "$ONE" ] && echo "ONE (length) is zero"
```

## 実行

```bash
$ ONE=1 ./main.sh
ONE is non-zero
$ ONE= ./main.sh
ONE (length) is zero
```

## 参考

- [<Bash, zsh> シェル変数が定義されているかを判定する方法 - ねこゆきのメモ](http://nekoyukimmm.hatenablog.com/entry/2018/01/21/101828)
