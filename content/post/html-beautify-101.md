---
title: "htmlをフォーマットするのにhtml-beautifyを使う"
slug: html-beautify-101
date: 2021-08-06T16:59:58+09:00
draft: false
author: sakamossan
---

html-beautify は html をフォーマットしてくれるCLIのツール。

- [beautify-web/js-beautify: Beautifier for javascript](https://github.com/beautify-web/js-beautify)

html-beautify は js-beautify を入れると入る。

```bash
$ yarn add js-beautify
```

### pup

htmlを整形できるツールだと pup というものがあるが、自分の環境だとマルチバイト文字が文字化けしてしまうので今回は見送り。

- [ericchiang/pup: Parsing HTML at the command line](https://github.com/ericchiang/pup)


## (例) ./out ディレクトリ配下のhtmlをすべてフォーマットする場合

いろいろオプションを渡してhtmlを生成することができる。

```bash
npx html-beautify \
    --replace \
    --indent-size=2 \
    --wrap-line-length=200 \
    --wrap-attributes=force-aligned \
    ./out/*.html
```

## 標準入力から整形する場合

標準入力から整形できるのも地味にうれしい。minifyされてしまったhtmlなどから展開する場合など。

```bash
$ pbpaste | html-beautify
```

