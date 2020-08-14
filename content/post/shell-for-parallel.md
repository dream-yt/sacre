---
title: "bashのfor文の中身を並列処理させる"
date: 2020-04-30T18:01:37+09:00
draft: false
author: sakamossan
---

こんなスクリプトがあったとして

```sh
for i ($find ./src); do
  somecommand $i
done
```

forの中身 (somecommand) を並列で実行したい場合はこうすればよい

```sh
for i ($find ./src); do
  somecommand $i &
done
wait
```

いままでxargsを使ったりもしてたが、waitを使う方が分かりやすくてよかった


## 参考

- [waitコマンド（子プロセスの完了を待つ） : JP1/Advanced Shell](http://itdoc.hitachi.co.jp/manuals/3021/3021313320/JPAS0399.HTM)

> pidを指定しなかった場合は，実行中のすべての子プロセスの完了を待ちます

