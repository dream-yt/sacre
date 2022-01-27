---
title: "perl の FindBin と splitで tsv ファイルを雑にパースする"
slug: perl-split-tsv-from-file-with-findbin
date: 2022-01-27T17:41:46+09:00
draft: false
author: sakamossan
---

こんな感じでtsvファイルを扱える。

```perl
#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;

open my $fh, '<', "$FindBin::Bin/_.tsv";
my @mapping = map { [split] } <$fh>;
...
```

このへんをメモ

- `$FindBin::Bin` について
- `split` 関数の仕様

### ファイルの読み込み

```perl
open my $fh, '<', "$FindBin::Bin/_.tsv";
```

- `FindBin::Bin` は nodejs の `__dirname` のようなもの
- ファイルを読み出すため、cwdを探すときに使う


### tsvのパース

1行でいろいろなことをしている。

```perl
my @pairs = map { [split] } grep { /\S/ } <$fh>;
```

- `<$fh>`
  - ファイルを1行づつ読んでループ(grepに渡す配列になっている)
- `grep { /\S/ }`
  - 改行のみのレコードを無視する

##### `[split]` は説明がもう少し必要

split は引数を与えないとこんな挙動になる。

> split emulates the default behavior of the command line tool awk when the PATTERN is either omitted or a string composed of a single space character (such as ' ' or "\x20", but not e.g. / /). In this case, any leading whitespace in EXPR is removed before splitting occurs, and the PATTERN is instead treated as if it were /\s+/; in particular, this means that any contiguous whitespace (not just a single space character) is used as a separator.

- [split - Perldoc Browser](https://perldoc.perl.org/functions/split)

つまり、

- 先頭の空白が除去されて
- `/\s+/` で split したことになる

また、EXPR も省略しているので `$_` に対して呼ばれたことになる。

省略されたものを補うとこんな感じになる。(自分以外が読むコードならちゃんと書いたほうがよい)

- `split(/\s+/, $_)` 
