---
title: "perl で windows の改行文字を chomp する"
slug: perl-chomp-windows-newline
date: 2021-07-10T10:17:12+09:00
draft: false
author: sakamossan
---

ファイル内の改行コードはOSごとに異なる。

- Windows: CR+LF （\r+\n）
- Linux（UNIX系OS）: LF （\n）
- MacOS X: LF （\n）

Linux <> MacOS で作業をしているわりには perl の chomp で問題がないが、
MacOS 上で windows のエクセルで生成された csv を扱い場合などはこのあたりを気にする必要がある。

chomp は改行の区切り文字を格納する特殊文字 `$/` を参照するので、これに Windows 向けの改行文字を入れてあげればよい。

### こんな感じ

```perl
local $/="\r\n";
while (<>) {
    chomp;
    ...
```

だいたいのページだと `s/\r\n//` の例で書いてあるが、`$/` と chomp を使うと変更箇所がちらばらなくていいんじゃないかなと思う。perlの仕様を知らないと直観的ではないのだが自分用のスクリプトなら問題ないだろう。


## 参考

- [とほほのperl入門（概要編） - とほほのWWW入門](https://www.tohoho-web.com/wwwperl1.htm)
- [ファイル内の改行コード変換（Perl） | ハックノート](https://hacknote.jp/archives/22105/)
