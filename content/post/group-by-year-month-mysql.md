---
title: "MySQLで月毎にGROUP BYする"
slug: group-by-year-month-mysql
date: 2021-12-08T15:28:24+09:00
draft: false
author: sakamossan
---

`modified` は変更されたら更新されるカラム。
以下のような表現で `202107` といった文字列を作ることができる。

```sql
CONCAT(YEAR(modified), LPAD(MONTH(modified), 2, '0'))
```

`GROUP BY YEAR(modified), MONTH(modified)` でもいいが、可視化のライブラリにて使うときに1カラムの方が具合がいいので `LPAD` などを使って1カラムの文字列にしている。


## 更新されたレコードを月毎で計上

```sql
SELECT CONCAT(YEAR(modified), LPAD(MONTH(modified), 2, '0')),
  COUNT(1)
FROM t
GROUP BY CONCAT(YEAR(modified), LPAD(MONTH(modified), 2, '0'))
ORDER BY CONCAT(YEAR(modified), LPAD(MONTH(modified), 2, '0'))
```


## 参考

- [sql - MySQL Query GROUP BY day / month / year - Stack Overflow](https://stackoverflow.com/questions/508791/mysql-query-group-by-day-month-year)
- [MySQL :: MySQL 5.6 リファレンスマニュアル :: 12.5 文字列関数](https://dev.mysql.com/doc/refman/5.6/ja/string-functions.html)
