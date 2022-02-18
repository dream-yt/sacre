---
title: "bashスクリプトのファイル名(拡張子抜き)を取得する"
slug: useful-bash-script-name
date: 2022-02-18T19:05:18+09:00
draft: false
author: sakamossan
---

ログやtmpファイルの名前に使ったりとかして便利なので、スクリプトの雛形スニペットでは、先頭で取得しておくことにしている。

```bash
readonly scriptname=$(basename ${0%.sh})
```
