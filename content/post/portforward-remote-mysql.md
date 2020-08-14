---
title: "ポートフォワードしてリモートのMySQLに接続する"
date: 2020-02-27T16:50:22+09:00
draft: false
author: sakamossan
---

リモートワークになったのでローカルの環境構築をしている

#### 各種変数を設定 

```bash
export SSH_USER=mossan
# `SSH_HOST` はここでは踏み台ホストのこと
export SSH_HOST=xxx.xxx.xxx.xxx
export DB_HOST=xxx.xxx.xxx.xxx
export DB_USER=app
export DB_NAME=prod
```

#### ポートフォワード設定

```bash
# ローカルの3306が埋まっていたので今回は33306を使う
$ ssh -f -N -L 33306:${DB_HOST}:3306 ${SSH_USER}@${SSH_HOST}
```

##### ssh の `-f` オプション

ssh の `-f` オプションはバックグラウンドでの実行になってくれる
バックグラウンドなので起動したシェルを落とすと死ぬ(かゾンビになる)はず

> -f    Requests ssh to go to background just before command execution.

#### mysql_config_editor で接続情報の簡単化

```bash
$ mysql_config_editor set \
  --login-path=prod-master-portforwarded-33306 \
  --host=127.0.0.1 \
  --port=33306 \
  --user=$DB_USER \
  --password
```

#### mycliでつないで確認

```bash
$ mycli --login-path=prod-master-portforwarded-33306 prod
```
