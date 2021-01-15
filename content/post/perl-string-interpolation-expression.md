---
title: "perlで文字列内に式を埋め込みたい時"
slug: perl-string-interpolation-expression
date: 2021-01-15T12:14:13+09:00
draft: false
author: sakamossan
---

`array (@) interpolation` というものが使える

- [Perlの文字列補間 - Wikipedia](https://ja.wikipedia.org/wiki/%E6%96%87%E5%AD%97%E5%88%97%E8%A3%9C%E9%96%93#Perl)

## 例

文字列内に `"baz" x 5` という式を埋め込みたい場合

```console
$ perl -E 'say qq(hello! @{["baz" x 5]} bye!)'
hello! bazbazbazbazbaz bye!
```
