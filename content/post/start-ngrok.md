---
title: "ngrokを使いはじめる"
date: 2019-10-30T12:02:06+09:00
draft: false
author: sakamossan
---

## サインアップ

アカウントをつくる必要がある
(GitHubアカウントでサインアップできる)

- [ngrok - secure introspectable tunnels to localhost](https://ngrok.com/)


## インストール/認証

サインアップするとngrokのダッシュボードにバイナリのダウンロードボタンがある
また、トークンもすでに払い出されてるのでそれを使って認証

```console
$ ./ngrok authtoken xxxxxxxx
Authtoken saved to configuration file: /Users/mossan/.ngrok2/ngrok.yml
```


## 外部からアクセス可能な状態にする

適当なポートにサーバをローカルでたてる

```
$ python3 -m http.server --bind 127.0.0.1 8000
```

そのポート番号を引数にコマンドを実行すると、 `ngrok.io` 配下にサブドメインが払い出されて、そのURLからローカルのサーバにアクセスできるようになる

```
$ ./ngrok http 8000
ngrok by @inconshreveable                                                                                                                                                                                                     (Ctrl+C to quit)

Session Status                online
Account                       sakamossan (Plan: Free)
Version                       2.3.35
Region                        United States (us)
Web Interface                 http://127.0.0.1:4040
Forwarding                    http://xxxx.ngrok.io -> http://localhost:8000
Forwarding                    https://xxxx.ngrok.io -> http://localhost:8000

```
