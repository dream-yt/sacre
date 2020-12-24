---
title: "perlでサブルーチンにモンキーパッチをあてる"
slug: perl-monkey-patch-subroutine
date: 2020-12-24T17:39:21+09:00
draft: false
author: sakamossan
---

ライブラリ内部の挙動を一時的に変更したい時、以下のように書いてメソッドを上書きすることができる。

```perl
sub f {
    # 警告の抑制
    no warnings 'redefine';
    # Foo::Bar クラスの roo メソッドを書き換え
    local *Foo::Bar::roo = sub { my $self = shift; ... }
}
```

あまり褒められたやりかたでないのでデバッグ中などあくまで一時的な対処で使う。
