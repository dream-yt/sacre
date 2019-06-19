---
title: "recodeコマンドでファイルの文字/改行コードを変更する"
date: 2019-06-19T17:09:44+09:00
draft: false
---

文字コードの変換をするときはiconvを使うことが多かったが、recodeコマンドのほうが便利なことが多い

- 既存ファイルに置き換え(inplace)で文字コードが変更できる
- 改行コード(CR-LFなど)の変換も対応している
- 複数ファイルを引数に取ることができる

たとえばディレクトリ配下のcsvファイルをすべて {UTF16 => UTF-8} と変更したい場合は下記の1行で済む

```bash
$ recode UTF-16..UTF-8 "$f" $(ls -1 ./*.csv)
```

## 対応している変換方式

対応している変換方式は `--list` で出てくる

base64なども変換できるようだ

```
$ recode --list | head
/21-Permutation swabytes
/4321-Permutation
/Base64 64 b64
/CR
/CR-LF cl
/Decimal-1 d d1
/Decimal-2 d2
/Decimal-4 d4
/Hexadecimal-1 x x1
/Hexadecimal-2 x2
```

### bash

インストールはmacならbrewで入る

```bash
brew install recode
```
