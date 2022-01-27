---
title: "npm install 時に npm ERR! enoent undefined ls-remote"
slug: npm-ERR-enoent-undefined-ls-remote
date: 2022-01-27T16:09:51+09:00
draft: false
author: sakamossan
---

npm install などでこういったエラーが出る場合がある。

> npm ERR! enoent undefined ls-remote -h -t

これは、GitHubに直接ホスティングされているパッケージの場合などに発生する者で、パッケージのダウンロードにgitを使うことに起因する。システムにgitが入っていないとこのようなエラーとなる。たとえば自分の場合はCloudBuildなどCDパイプライン上で発生した(gitが入っていなかった)

解決方法はシステムに git を入れることである。


## 参考

- [Solution for npm ERR! enoent undefined ls-remote -h -t | by Anna Coding | Anna Coding | Medium](https://medium.com/anna-coding/solution-for-npm-err-enoent-undefined-ls-remote-h-t-18ab6f8274af)

