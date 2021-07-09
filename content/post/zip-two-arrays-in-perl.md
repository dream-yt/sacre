---
title: "perlで2つの配列をzipする"
slug: zip-two-arrays-in-perl
date: 2021-07-09T15:46:32+09:00
draft: false
author: sakamossan
---

なんかすごいやりかたばかり出てくる。

- [Is there an elegant zip to interleave two lists in Perl 5? - Stack Overflow](https://stackoverflow.com/questions/38345/is-there-an-elegant-zip-to-interleave-two-lists-in-perl-5)

たぶんいちばんわかりやすいのはこれ。

```perl
my @a = (...);
my @b = (...);
my %c = map {$a[$_] => $b[$_]} (0..$#a);
```

ツッコまれてたけどそれは前提の問題だと思う。

> This has problems for unequally-sized arrays. – brian d foy Jan 3 '10 at 17:47
