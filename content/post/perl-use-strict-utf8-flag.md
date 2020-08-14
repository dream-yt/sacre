---
title: "perlのstrict/utf8フラグについて"
date: 2019-07-30T14:42:22+09:00
draft: false
author: sakamossan
---

なんとなく知識では知っていたけど試したことがなかったのでメモ

perlにはstrictフラグというものがあって、
構文エラーにならないけど変な式を書いてるとエラーにしてくれる仕組みがある

```perl
#!/usr/bin/env perl
use strict;
```

- [strict - 安全ではない構文を制限する Perl プラグマ - perldoc.jp](https://perldoc.jp/docs/perl/strict.pod)


## strict

### use strict

```perl
use strict;
$r = 1;
```

`my` をつけないで変数宣言をしているのでstrictモードだとエラーになる

```console
$ carton exec perl -Ilib -It/lib ,/checkstrict.pl
Global symbol "$r" requires explicit package name at ,/checkstrict.pl line 7.
Execution of ,/checkstrict.pl aborted due to compilation errors.
```


### no strict "vars"

- `no strict` でフラグは無効化できる
- これはブロック内のみの無効化となる

```perl
use strict;
no strict "vars";
$r = 1;
```

strictフラグが降りてるのでこれはOK


### blockの中だけ no strict

ドキュメントに書いてある通りの挙動

```perl
use strict;

{
  no strict "vars";
  $s = 0;
}
```

ブロックの外は引き続きダメ

```perl
use strict;

{
  no strict "vars";
  $s = 0;
}

$r = 1;
```

```console
$ carton exec perl -Ilib -It/lib ,/checkstrict.pl
Global symbol "$r" requires explicit package name at ,/checkstrict.pl line 13.
Execution of ,/checkstrict.pl aborted due to compilation errors.
```

### `use strict` してる別ファイルのモジュールをuseしたとき

`t/Utils.pm` という以下のようなファイルを作って、それをuseした場合

```perl
package t::Utils;
use strict;
1
```

```perl
use t::Utils;
$r = 1;
```

これはstrictフラグがたっておらず、エラーにならない
(ただし、同じファイルでパッケージ違いの場合はエラーになる)


## utf8

utf8も同様の挙動

次のように書くと `utf8 flag on` が表示される
(utf8フラグがオンだと全角スペースが `\s` 正規表現でひっかかる)

```perl
use utf8;
my $zenkaku_space = "　";
print "utf8 flag on\n" if $zenkaku_space =~ /\s/;
```

```console
utf8 flag on
```

### no utf8

`no utf8` すると表示されない (フラグがオフになる)

```perl
use utf8;
no utf8;

my $zenkaku_space = "　";
print "utf8 flag on\n" if $zenkaku_space =~ /\s/;
```

### no utf8 とブロック

`no utf8` はstrict同様ブロック内だけ

ちょっとはまったが、代入した行でフラグがどうなってるかが大事
(フラグが立ってるところで代入された全角スペースは `\s` がひっかかる)

```perl
use utf8;
my $zenkaku_space;
{
  no utf8;
  print "utf8 flag on\n" if "　" =~ /\s/;
}
print "still utf8 flag on\n" if "　" =~ /\s/;
```

```console
$ carton exec perl ,/checkstrict.pl
still utf8 flag on
```

### 別ファイル

strictと同様
`use utf8` している別ファイルをuseしてもフラグはたたない

```perl
use t::Utils;
print "utf8 flag on\n" if "　" =~ /\s/;
```

## その他

ちなみに、ライブラリを書いていて、useされたときにuseした側にフラグを立てたい場合はこんな風に書く

```perl
use strict;
use utf8;

sub import {
    strict->import;
    utf8->import;
}
```

## まとめ

- プラグマモジュールの挙動としてstrictもutf8も同じ
- `no 〜` でフラグが降ろせるのはブロック内だけ
- フラグは別ファイルには伝播しない
- ただし伝播させる方法もある


## 参考

- [warnings - 選択的な警告を調整する Perl プラグマ - perldoc.jp](http://perldoc.jp/docs/perl/warnings.pod)
- [perlmodlib - 新たな Perl モジュールを作ったり、既にあるものを検索する - perldoc.jp](https://perldoc.jp/docs/perl/5.10.1/perlmodlib.pod#Pragmatic32Modules)
- [毎回use strict/warnings書くのがめどい - 新だるろぐ跡地](https://foosin.hatenablog.com/entry/20090326/1238078061)
