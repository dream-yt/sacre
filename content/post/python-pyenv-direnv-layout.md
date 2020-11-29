---
title: "python(pyenv) と direnv を組み合わせる"
slug: python-pyenv-direnv-layout
date: 2020-11-29T17:07:29+09:00
draft: false
author: sakamossan
---

検索すると日本語の記事は `.envrc` で `source ./venv/bin/activate` するのが出てくるが、
ディレクトリを出ても deactivate が効かないので少し不便。

公式の説明にならって layout を使うのがよさそうだった。

## .envrc

```bash
layout pyenv 3.8.4
```

初回起動時に `.direnv` ディレクトリにvenvを作ってくれる。
cdで移動してくれば自動的に activate され、出ていけば deactivate される。

## 参考

- [Python · direnv/direnv Wiki](https://github.com/direnv/direnv/wiki/Python)
