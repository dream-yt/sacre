---
title: "perlでデータクラスを7行で定義する"
slug: perl-dataclass-7line
date: 2021-07-30T18:28:40+09:00
draft: false
author: sakamossan
---

テストのモック役をしてもらうために作った。

```perl
package Klass;
sub new {
    my ($class, %hash) = @_;
    for my $k (keys %hash) {
        no strict 'refs';
        *{$k} = sub { $hash{$k} };
    };
    bless {}, $class;
};
package main;
my $obj = Klass->new(one => 1, two => 2);
warn $obj->one;
warn $obj->two;
```

プロダクションのコードでは `Class::Accessor` を使うのがよい。


## メモ

- `package main` が定義のない場合のパッケージ名
- `no strict 'refs'` はシンボリックリファレンスの解禁
    - 動的に変数名や関数名を定義する操作
- `*{$k} = sub { $hash{$k} }` で動的にメソッドを定義
    - Klass パッケージに定義されるのでインスタンスから呼べる
