---
title: "MySQLでWhere句に正規表現を使う"
slug: mysql-regexp
date: 2021-02-12T14:26:02+09:00
draft: false
author: sakamossan
---

こんな構文で正規表現で検索することができる

```sql
SELECT * FROM t WHERE url REGEXP 'https://.+:.+@.+'
```

ただし PCRE ではないので最低限のものしか使えない

正規表現が期待通りに書けてるかのテストはこんな感じでやるとよい

```sql
SELECT 'a' REGEXP '^[a-d]';
```

## 参考

- [MySQL :: MySQL 5.6 リファレンスマニュアル :: 3.3.4.7 パターンマッチング](https://dev.mysql.com/doc/refman/5.6/ja/pattern-matching.html)
- [MySQL :: MySQL 5.6 リファレンスマニュアル :: 12.5.2 正規表現](https://dev.mysql.com/doc/refman/5.6/ja/regexp.html)
