---
title: "/usr/local/Cellar/pyenv/1.2.8/libexec/pyenv: No such file or directory"
date: 2020-08-12T11:49:42+09:00
draft: false
---

brewで色々アップグレードされたあと、pyenvで入れたpythonが動かなくなることがある

```bash
$ code
/Users/sakamoto/.pyenv/shims/python: 行 21: /usr/local/Cellar/pyenv/1.2.8/libexec/pyenv: No such file or directory
/usr/local/bin/code: 行 10: ./MacOS/Electron: No such file or directory
```

pyenvで入れたpython (~/.pyenv/shims/python) はbashスクリプトになっていて、以下の行にもう存在しないパスがハードコードされてるので発生している

```bash
$ tail -1 ~/.pyenv/shims/python
exec "/usr/local/Cellar/pyenv/1.2.8/libexec/pyenv" exec "$program" "$@"
```

これは `pyenv rehash` で直る

```bash
$ pyenv rehash
```

```bash
$ tail -1 ~/.pyenv/shims/python
exec "/usr/local/Cellar/pyenv/1.2.20/libexec/pyenv" exec "$program" "$@"
```

rehashは現在のshimsのパスに張り替えたスクリプトを作り直してくれるもの

- [pyenv/pyenv-rehash at d08c9cfb362c5a7e18a92acd2253a16935ad9a99 · pyenv/pyenv](https://github.com/pyenv/pyenv/blob/d08c9cfb362c5a7e18a92acd2253a16935ad9a99/libexec/pyenv-rehash#L64)

本来だと自動的にrehashがされるはず、とのことだがたぶんbrewが勝手にpyenv自体のパスを変えてしまうのでそれをカバーするのは無理なのだろう。困ってる人たくさんいるみたいなのでエラーメッセージがもうちょい親切になってればいいのかもしれない

- [RFE: pyenv update should regenerate shims unconditionally · Issue #1068 · pyenv/pyenv](https://github.com/pyenv/pyenv/issues/1068)


