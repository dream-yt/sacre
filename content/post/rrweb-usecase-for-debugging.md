---
title: "rrwebがバグの調査に使えそうというメモ"
date: 2020-08-06T15:48:59+09:00
draft: false
author: sakamossan
---

rrwebはサイトでユーザがなにをしたかを記録できるというもの

- [rrweb-io/rrweb: record and replay the web](https://github.com/rrweb-io/rrweb)

> rrweb refers to 'record and replay the web', which is a tool for recording and replaying users' interactions on the web.

ユーザの行動調査のために使うのかとおもったら、exampleで「エラーが発生したときにユーザがどんな操作をしていたか」をキャプチャするための設定が書かれていて、なるほどとなった。

- [rrweb/guide.md / capturing just the last N events from when an error has occurred](https://github.com/rrweb-io/rrweb/blob/master/guide.md#user-content-checkout)

ブラウザ側で発生している原因が不明なエラーなど、自分でいろいろデバッグ用のコードを埋め込むよりこれを使った方がいいなってなった
