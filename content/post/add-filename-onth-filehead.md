---
title: "ファイル名をファイルの先頭に追加する(ディレクトリ配下全部)"
slug: add-filename-onth-filehead
date: 2020-11-23T11:29:52+09:00
draft: false
author: sakamossan
---

1ファイルだけならいいが、何百とファイルがあると手作業でやるのはかなり辛い。
今回はブログ記事が書いてあるファイル全部に[フロントマター](https://qiita.com/amay077/items/e27f9b4e2374b70a5dfb)に1項目追加したかったので、1コマンドこさえた。

こんなコマンドでできる

```bash
$ ls -1 | xargs -I{} gsed -i -e '1i {}' {}
```

### ls

> ls -1

ファイル名を一覧するのに使う

### xargs

> xargs -I{}

- パイプされた1行に対して同じコマンドを発行する
- ファイル名のリストがパイプされているので、1ファイル1コマンド発行される
- `{}` はプレースホルダ
    - `{}` がパイプされた1行に置換されてコマンドが実行される

### gsed

macOSでLinux版のsedを使いたかったのでgsed。

gsedはbrewでインストールできる。

- [gnu-sed — Homebrew Formulae](https://formulae.brew.sh/formula/gnu-sed)

> -i

ファイルを直接書き換えるという指示。
引数に文字列を渡すとその名前のファイルを生成する。

> 1i

`1i ~~` で「1行目に~~という文字列を入れる」という指示になる。
この改行も一緒に入る。


## 参考

- [【 xargs 】コマンド――コマンドラインを作成して実行する：Linux基本コマンドTips（176） - ＠IT](https://www.atmarkit.co.jp/ait/articles/1801/19/news014.html)
- [ある文字列をファイルの特定行に挿入するコマンド - 元RX-7乗りの適当な日々](https://www.na3.jp/entry/20110310/p1)
