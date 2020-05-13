---
title: "MySQLで、URLからホスト部まで抜き出す"
date: 2020-05-13T12:56:31+09:00
draft: false
---

ちょっとサボって `https://` などのスキーマ部も入る形

```sql
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(url, '/', 3), '?', 1) FROM t
```

## 参考

熱い議論が交わされている

- [Mysql query to extract domains from urls - Stack Overflow](https://stackoverflow.com/questions/9280336/mysql-query-to-extract-domains-from-urls)
