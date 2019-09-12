---
title: "macosでデフォルトで開くアプリをコマンドライン(duti)で変更する"
date: 2019-09-12T12:29:58+09:00
draft: false
---

macosでは各拡張子ごとにデフォルトで開くアプリが決まっている

Finderから変更はできるが、扱う拡張子はけっこうたくさんあるのでいちいち変更するのがとても面倒なのでスクリプト化できるcliで変更したい

## duti

duti を使えばコマンドラインからデフォルトアプリが変更できる

- [moretension/duti: A command-line tool to select default applications for document types and URL schemes on Mac OS X](https://github.com/moretension/duti)

### install

brew で入る

```console
$ brew install duti
...
$ duti -h
usage: duti [ -hvV ] [ -d uti ] [ -l uti ] [ settings_path ]
usage: duti -s bundle_id { uti | url_scheme } [ role ]
usage: duti -x extension
```

### 表示

`-x` オプションと拡張子で、いまデフォルトになにが設定されているか確認できる

```console
$ duti -x .md
Xcode
/Applications/Xcode.app
com.apple.dt.Xcode
```


### 変更

`-s` オプションと拡張子,アプリURIで、デフォルトアプリを設定できる

```console
$ duti -s com.microsoft.VSCode .md all
$ duti -x .md  # 確認
Visual Studio Code
/Applications/Visual Studio Code.app
com.microsoft.VSCode
```
