---
title: "perlでmysqlに接続してデータを入れる"
slug: mysql-generate-testdata-macos-sqlmaker
date: 2020-12-22T19:19:03+09:00
draft: false
author: sakamossan
---

`SQL::Maker::Plugin::InsertMulti` を使ってテストデータをmysqlに入れたい場合に困ったのでメモ。
macOSで普通にやると `DBD::mysql` が入らないのだが、これは環境変数から設定してなんとかする。

```bash
$ cat <<__CPANFILE > ./cpanfile
requires "DBI";
requires "SQL::Maker";
requires "SQL::Maker::Plugin::InsertMulti";
requires "DBD::mysql";
__CPANFILE
# https://twitter.com/yukiex/status/1083252296140578816
$ PATH="$(brew --prefix mysql-client)/bin:$PATH"
$ export LIBRARY_PATH=$(brew --prefix openssl)/lib:$LIBRARY_PATH
$ carton install
```

```perl
#!/usr/bin/env perl
use strict;
use warnings;
use DBI;
use SQL::Maker;
SQL::Maker->load_plugin('InsertMulti');

my $table = 't1';
my @rows = ({ id => 100, name => 'a'}, { id => 200, name => 'b'});
my $s = SQL::Maker->new(driver => 'mysql');
my ($sql, @binds) = $s->insert_multi($table, \@rows);

my $dbh = DBI->connect("dbi:mysql:dbname=test;host=127.0.0.1", "root");
$dbh->prepare($sql)->execute(@binds);
```

## 参考

- [macOS(mojave)にDBD::mysqlをインストールしたいっ！ – thinking now…](https://blog.mitsuto.com/macos-mojave-perl-dbd-mysql)
- [SQL::Maker::Plugin::InsertMulti - insert multiple rows at once on MySQL - metacpan.org](https://metacpan.org/pod/SQL::Maker::Plugin::InsertMulti)
