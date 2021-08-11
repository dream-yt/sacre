---
title: "Pythonのインストールで 「'sendfile' is invalid in C99」"
slug: install-py36-sendfile-error
date: 2021-08-11T11:58:52+09:00
draft: false
author: sakamossan
---

python3.6 を pyenv で入れようとしたら以下のエラーで入らなかった。

> error: implicit declaration of function 'sendfile' is invalid in C99

もろもろビルドフラグをつける必要があった。以前にはこんな色々やらなくてよかったはずだが、何が変わったのだろう?
もちろん事前に `brew` や `xcode-select --install` で色々いれておく必要がある。

```bash
$ export LDFLAGS="-L/usr/local/opt/zlib/lib"
$ export CPPFLAGS="-I/usr/local/opt/zlib/include"
$ export CFLAGS="\
    -I$(brew --prefix openssl)/include \
    -I$(brew --prefix bzip2)/include \
    -I$(brew --prefix readline)/include \
    -I$(xcrun --show-sdk-path)/usr/include" \
$ export LDFLAGS="\
    -L$(brew --prefix openssl)/lib \
    -L$(brew --prefix readline)/lib \
    -L$(brew --prefix zlib)/lib \
    -L$(brew --prefix bzip2)/lib" \
$ pyenv install --patch 3.6.13 < <(curl -sSL https://github.com/python/cpython/commit/8ea6353.patch\?full_index\=1)
```

## 参考

- [unable to install python 3.8.0 on macox 11 · Issue #1740 · pyenv/pyenv](https://github.com/pyenv/pyenv/issues/1740#issuecomment-738749988)
