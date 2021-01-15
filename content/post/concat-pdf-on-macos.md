---
title: "macOSのターミナルで複数のPDFを1つにまとめる"
slug: concat-pdf-on-macos
date: 2021-01-11T10:51:02+09:00
draft: false
author: sakamossan
---

macだと以下の場所に結合してくれるスクリプトが置いてある。

> /System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py

## 使い方

```bash
$ PDFconcat --help
Usage: join [--output <file>] [--shuffle] [--verbose]
```

- `-o` で出力先のパスを指定
- そのあとに結合したいpdfファイルのパスを列挙

だいたいこんな使い方になる。

```
$ PDFconcat -o ./all.pdf ./*.pdf
```


## シンボリックリンク

シンポリックリンクを作っておくと楽。

```bash
sudo ln -s "/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" /usr/local/bin/PDFconcat
```


## 参考

- [Joining PDF files in OS X from the command line || Fritz Stelluto](https://gotofritz.net/blog/howto/joining-pdf-files-in-os-x-from-the-command-line/)
