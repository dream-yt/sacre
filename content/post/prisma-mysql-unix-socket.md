---
title: "prisma-client と MySQL を unix socket で接続する"
slug: prisma-mysql-unix-socket
date: 2021-04-17T21:38:14+09:00
draft: false
author: sakamossan
---

ドキュメントには「ディレクトリを指定する」という書き方になっているが、もちろん実際はファイルのフルパスを入れないとつながらない。

> socket	Points to a directory that contains a socket to be used for the connection

- [MySQL database connector (Reference) | Prisma Docs](https://www.prisma.io/docs/concepts/database-connectors/mysql)

たとえばこんな設定で接続できる。

```s
DATABASE_URL=mysql://root:@localhost:3306/myappdb?socket=/tmp/mysql.sock
```

ホスト名は 127.0.0.1 ではなく localhost である必要がある。
MySQL は 127.0.0.1 と指定されるとTCP接続を取ろうとするため。


## その他

下記のissueで当初間違った情報が案内されてちょっと困った(最後まで読まないとダメ)。MySQL だと `socket` というパラメータ名だが、Postgres だと `host` なんだそうだ。

- [Error in google cloud run connecting with cloud SQL · Issue #1508 · prisma/prisma](https://github.com/prisma/prisma/issues/1508)

コード的にはここ (括弧はあってもなくてもよい)

- [quaint/mysql.rs at 8c4544130e1fe1cbc0f95ec3b21e616763774808 · prisma/quaint](https://github.com/prisma/quaint/blob/8c45441/src/connector/mysql.rs#L166)

