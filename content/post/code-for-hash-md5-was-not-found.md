---
title: "ERROR:root:code for hash md5 was not found"
date: 2020-02-06T15:08:17+09:00
draft: false
author: sakamossan
---

僕のPCはbrewがopensslがアップデートするたびにこのエラーがでる。1年毎くらいに発生するので毎回発生するたびに原因と対処方法は忘れている

## 原因

pythonがlinkしていたopensslがなくなってしまって発生している

## 対応

pythonをリビルドすれば直る

```bash
$ brew reinstall python@2
```

ただ、この方法だと付随してcsvkitやansibleなどの依存が上がってしまう


## 参考

- [python - ERROR:root:code for hash md5 was not found - not able to use any hg mercurial commands - Stack Overflow](https://stackoverflow.com/questions/59269208/errorrootcode-for-hash-md5-was-not-found-not-able-to-use-any-hg-mercurial-co)
