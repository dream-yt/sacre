---
title: "MySQLで最初にユーザとデータベースを作成する"
slug: mysql-create-database-and-user
date: 2021-04-11T12:40:25+09:00
draft: false
author: sakamossan
---

アプリを作り始めるときにやる手順。MySQL8での作業。

## データベースの作成

`COLLATE` は、`utf8mb4_bin` が一番厳密な区別(全角/半角の区別など)を行ってくれるのでまずそれを検討し、アプリの要件によっては `utf8mb4_ja_0900_as_cs` など少し親切なものを使う。

```sql
CREATE DATABASE myapp DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
```

## ユーザの作成

いったん権限はすべてつけて作成してしまう。一通り作業がひと段落したらアプリごとの要件によって棚卸し。

```sql
CREATE user 'myappadmin' @'localhost' IDENTIFIED by 'xxxxxxxxxxxxxxxxx';
GRANT ALL ON myapp.* TO 'myappadmin' @'localhost' WITH GRANT OPTION;
```

なお、 `FLUSH PRIVILEGES` は権限管理専用のステートメントを使っていれば不要なんだそうだ。

- [MySQLのFLUSH PRIVILEGESが必要なケース | my opinion is my own](https://zatoima.github.io/mysql-flush-privileges.html)

### 参考

- [日々の覚書: MySQL 8.0.1でutf8mb4_ja_0900_as_csが導入された](https://yoku0825.blogspot.com/2017/04/mysql-801utf8mb4ja0900ascs.html)l
- [MySQLインストール時にやること（DBとユーザーの作成等） - Qiita](https://qiita.com/daichi87gi/items/f9dac6cd8acc3ad4330d)
- [MySQLのFLUSH PRIVILEGESが必要なケース | my opinion is my own](https://zatoima.github.io/mysql-flush-privileges.html)
