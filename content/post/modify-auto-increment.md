---
title: "MySQL、 auto incrementの確認と変更"
date: 2019-03-15T17:33:58+09:00
draft: false
---

#### 確認

```sql
show table status where Name = '{{ テーブル名 }}'\G
```

#### 変更

```sql
ALTER TABLE '{{ テーブル名 }}' AUTO_INCREMENT = 1000000;
```

#### 参考

- [MySQLでAUTO_INCREMENTを任意の数字に変更する - Bouldering & Com.](https://shrkw.hatenablog.com/entry/how_to_change_auto_increment_number_on_mysql)
