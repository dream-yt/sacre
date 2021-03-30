---
title: "mysqlのパスワードをいちいち入力しないで済む mysql_config_editor"
slug: mysql-login-path-101
date: 2021-03-30T17:50:39+09:00
draft: false
author: sakamossan
---

mysql_config_editor を使えばパスワードを安全に保管することができて、毎度入力しないで済む。
パスワードを取り出しやすいところに置いておく必要がある運用よりも安全だと考えられる。


## 使いかた

まず接続情報を登録する。

```bash
mysql_config_editor set -G $NAME -h $MYSQL_HOST -u $USER -p
```

`$NAME` はログインする時に使う接続情報につける名前

```bash
$ mycli --login-path=$NAME
```

mycliでも使えるのが便利。


#### 参考

- [MySQLへの接続を楽にする - Qiita](https://qiita.com/rmanzoku/items/0502f2c40467a596f8db)
- [ポートフォワードしてリモートのMySQLに接続する](https://blog.n-t.jp/tech/portforward-remote-mysql/)
