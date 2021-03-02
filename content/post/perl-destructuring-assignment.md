---
title: "perlでjsの分割代入 (Destructuring assignment) みたいなことをする"
slug: perl-destructuring-assignment
date: 2021-03-02T12:14:12+09:00
draft: false
author: sakamossan
---

jsほどスマートじゃないが、それっぽいことはできる

## 例

こんなデータがあるとして

```perl
my $h = {
    a => 1,
    b => 2,
};
```

こうやって取り出す

```perl
my ($a, $b) = @$h{qw/a b/};
```
