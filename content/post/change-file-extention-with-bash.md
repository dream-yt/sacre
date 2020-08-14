---
title: "bashでファイルの拡張子を一括変更する"
date: 2019-07-16T11:23:13+09:00
draft: false
author: sakamossan
---

たとえばsrc配下のjsファイルをぜんぶtsファイルに変更したい場合は以下のように書ける

```bash
$ find ./src -name '*.js' -type f \
  | perl -wnlE '/(\S+).js/ and say "$1.js $1.ts"' \
  | xargs -n2 mv
```

## 動作

- `find ./src -name '*.js' -type f`
  - `**/*.js` なファイルパスを集めてきている
  - eg: `./src/app/pages/index.js`
- `perl -wnlE '/(\S+).js/ and say "$1.js $1.ts"'`
  - 受け取ったファイルパスからjsをとってtsをつけて出力
  - eg: `./src/app/pages/index.js ./src/app/pages/index.ts`
- `xargs -n2 mv`
  - mv にふたつのファイル名を渡してリネーム


`xargs -n2` は以下のように書いてある

```
-n number
        Set the maximum number of arguments taken from standard input for each invocation of utility.  An invocation of utility will use less than number standard input arguments if
        the number of bytes accumulated (see the -s option) exceeds the specified size or there are fewer than number arguments remaining for the last invocation of utility.  The
        current default value for number is 5000.
```

-n2で2個づつ処理してくれるようになる

> Set the maximum number of arguments


## 参考

- [大量のファイルをシェルのコマンドで一括リネームする ｜ DevelopersIO](https://dev.classmethod.jp/etc/rename_massive_files/)


## その他

Linuxだとrenameコマンドというのがあって便利なようだ

- [UbuntuTips/FileHandling/RenameCommand - Ubuntu Japanese Wiki](https://wiki.ubuntulinux.jp/UbuntuTips/FileHandling/RenameCommand)

perlスクリプトで、File::Rename::rename を呼んでいるだけだった
(移植できないもんなのかな)

- [File::Rename - Perl extension for renaming multiple files - metacpan.org](https://metacpan.org/pod/File::Rename)

```
cat /usr/bin/rename
```

作者はLarry Wall

```
=head1 AUTHOR

Larry Wall
```
