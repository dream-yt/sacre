---
title: "MySQLのrootパスワードを忘れてしまった時になんとかする方法"
slug: forget-mysql-root-password
date: 2021-03-04T17:39:58+09:00
draft: false
author: sakamossan
---

当該サーバでMySQLを再起動できる権限は必要

## 手順

- rootのpasswordをUPDATEするDMLが書いてあるファイルを用意する
- MySQLを一度止める
- mysqld_safeから`--init-file`オプション付きで起動する

### コマンド

```bash
$ echo "UPDATE mysql.user SET Password=PASSWORD('fuckofftaro') WHERE User='root';" >> /tmp/myinit
$ echo "FLUSH PRIVILEGES;" >> /tmp/myinit
$ mysqld_safe --init-file=/tmp/myinit &
mysqld_safe Logging to '/usr/local/var/mysql/Mac-137.err'.
mysqld_safe Logging to '/usr/local/var/mysql/Mac-137.err'.
mysqld_safe Starting mysqld daemon with databases from /usr/local/var/mysql
$ mysql -uroot -pfuckofftaro -e 'status'
mysql: [Warning] Using a password on the command line interface can be insecure.
--------------
mysql  Ver 14.14 Distrib 5.7.17, for osx10.10 (x86_64) using  EditLine wrapper

Connection id:		5

... (中略) ...

60  Queries per second avg: 0.203
--------------
```

## 参考

- [MySQL :: MySQL 5.6 リファレンスマニュアル :: B.5.4.1 root のパスワードをリセットする方法](https://dev.mysql.com/doc/refman/5.6/ja/resetting-permissions.html#resetting-permissions-unix)
