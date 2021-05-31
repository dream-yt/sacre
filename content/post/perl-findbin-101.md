---
title: "perlでモジュール検索パスの追加に `FindBin` を使う"
slug: perl-findbin-101
date: 2021-05-31T11:15:14+09:00
draft: false
author: sakamossan
---

### まず `FindBin` とは

- `FindBin` を use したスクリプトのディレクトリ名(絶対パス)を取得してくれる
- 「実行しているスクリプトの所在がわかる」とも言える

`FindBin` で取得したパスを使って、モジュール読み込みパスにlib配下を追加する

```perl
use FindBin;
use lib "$FindBin::Bin/lib";
```

## FindBin::libs とは

> FindBin::libs - locate and a 'use lib' or export directories based on $FindBin::Bin.

↑で示した読み込みパスへの `lib` ディレクトリの追加ごとやってくれるパッケージ。
探してくれるディレクトリ名はオプションで指定することができるが、デフォルトは `lib` となっている。

```perl
# same as above with explicit defaults.
use FindBin::libs qw( base=lib use=1 noexport noprint );
```

## 動作

`FindBin::libs` を使うと `@INC` がどのように変わるかを確認する

### まず使わない場合

```perl
#!/usr/bin/env perl
print join("\n", @INC);
```

```console
/usr/local/lib/perl5/site_perl/5.32.1/x86_64-linux-gnu
/usr/local/lib/perl5/site_perl/5.32.1
/usr/local/lib/perl5/vendor_perl/5.32.1/x86_64-linux-gnu
/usr/local/lib/perl5/vendor_perl/5.32.1
/usr/local/lib/perl5/5.32.1/x86_64-linux-gnu
/usr/local/lib/perl5/5.32.1
```

### まず使った場合

`/proj/app/tools/_.pl` を実行した場合

```perl
#!/usr/bin/env perl
use FindBin::libs;
print join("\n", @INC);
```

```console
/proj/app/lib
/usr/local/lib/perl5/site_perl/5.32.1/x86_64-linux-gnu
/usr/local/lib/perl5/site_perl/5.32.1
/usr/local/lib/perl5/vendor_perl/5.32.1/x86_64-linux-gnu
/usr/local/lib/perl5/vendor_perl/5.32.1
/usr/local/lib/perl5/5.32.1/x86_64-linux-gnu
/usr/local/lib/perl5/5.32.1
```

`/proj/app/lib` というパスが `@INC` に追加されているのがわかる。


## その他

モジュールの検索パスを `@INC` に追加する方法は以下の3つがある

- コード上で `@INC` を操作する
- perlの起動オプション `-I` 
- 環境変数 `PERL5LIB`

意図しないパスが `@INC` に追加されている場合は環境変数 `PERL5LIB` が使われてるかもしれない。

# 参考

- [@INC にみる Perl のやりかたがいっぱい - Articles Advent Calendar 2010 Casual](https://perl-users.jp/articles/advent-calendar/2010/casual/18)
- [FindBin::libs - locate and a 'use lib' or export directories based on $FindBin::Bin. - metacpan.org](https://metacpan.org/pod/release/LEMBARK/FindBin-libs-1.8/lib/FindBin/libs_curr.pm)
- [FindBin - スクリプトが存在するディレクトリのパスを取得 - Perlゼミ](https://tutorial.perlzemi.com/blog/20100524127696.html)
