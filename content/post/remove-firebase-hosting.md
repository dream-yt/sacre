---
title: "Firebase Hosting のサイトを削除する"
date: 2020-05-02T10:01:52+09:00
draft: false
---

firebase hosting は以下の要領でサイトを消すことができる


### まずはdisableに

```console
$ firebase hosting:disable
? Are you sure you want to disable Firebase Hosting?
  This will immediately make your site inaccessible! Yes
✔  Hosting has been disabled for pjx-112312. Deploy a new version to re-enable.

```


### リリースを削除


このコマンド実施後に `リリース履歴` のリストから直前のリリースを削除

ただ、サイトは閲覧できなくできるが、デプロイ履歴などは消せないようだ


## 参考

- [How do I remove a hosted site from firebase - Stack Overflow](https://stackoverflow.com/questions/42591099/how-do-i-remove-a-hosted-site-from-firebase)
