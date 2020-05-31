---
title: "golangで相対パスっぽいimportをできるようにする"
date: 2020-03-13T17:54:21+09:00
draft: false
---

※ おそらくよくないやりかたである

goではv1.11から相対パスのimportができなくなったとのこと

- [Go1.11からのGo Modulesでは相対パスImportは全くできなくなったので注意 - Qiita](https://qiita.com/momotaro98/items/23fa4356389a7e610acc)

以下の要件でなんとかする場合

- `github/~~` みたいなimportを用意したくない
- コードをdropboxに置いておきたい
- 既存のコードを変更したくない
- 自分しか触らないコード (滅茶苦茶していい)

`$GOPATH/src` の中身なら参照されるので、そこにシンボリックリンクを貼る方法にしたところちゃんと動いた (というかvscode上でエラーにはならなくなった)

```
$ ln -s $(pwd)/mygocli ~/.go/src/
```
