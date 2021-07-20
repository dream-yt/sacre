---
title: "nodejsで開発をしているとあたるエラーコード"
slug: unix-errno-list
date: 2021-07-20T10:56:11+09:00
draft: false
author: sakamossan
---

nodejsで開発をしているとUNIXのerrnoにあたることがよくある。いろいろあるが見覚えがあるものだけメモ。

- [3.2.1 メッセージに出力されるエラーコード一覧](http://software.fujitsu.com/jp/manual/manualfiles/M060085/J2X14850/01Z200/sdusr03/sdusr150.html)


##### ECONNREFUSED

- 相手先サーバとのセション接続が拒否されました


##### ECONNRESET

- サーバまたはクライアントとのセションが切断されました


##### ECLIENT

- クライアント側からセションが切断されました
