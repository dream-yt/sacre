---
title: "MySQLでマルチバイト文字が入ったレコードだけ取得する"
slug: mysql-query-multibyte-string
date: 2020-09-23T16:56:21+09:00
draft: false
author: sakamossan
---

マルチバイト文字が入ってそうなカラムの文字列を `CONVERT(x USING ASCII)` して、元の文字列と差分があれば NOT ASCII な文字列が入っていると判断できる。

## 例

`t.s` がマルチバイト文字がはいってそうなカラムだとするとこんな感じになる

```sql
SELECT * from t where s <> CONVERT(s USING ASCII);
```

## 参考

- [How can I find non-ASCII characters in MySQL? - Stack Overflow](https://stackoverflow.com/questions/401771/how-can-i-find-non-ascii-characters-in-mysql/11741314#11741314)


