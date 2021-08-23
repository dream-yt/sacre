---
title: "PDFを白黒にする"
slug: make-pdf-grayscale
date: 2021-08-23T14:44:04+09:00
draft: false
author: sakamossan
---

印刷でいちいち白黒を設定するのが面倒で調べた。
ghostscript で以下のようにオプションをわたしてあげたらキレイにモノクロになった。

```bash
$ gs \
   -sDEVICE=pdfwrite \
   -sProcessColorModel=DeviceGray \
   -sColorConversionStrategy=Gray \
   -dOverrideICC \
   -o ./mono.pdf \
   -f ./color.pdf
```

## 参考

- [ghostscript - How to convert a PDF to grayscale from command line avoiding to be rasterized? - Stack Overflow](https://stackoverflow.com/questions/20128656/how-to-convert-a-pdf-to-grayscale-from-command-line-avoiding-to-be-rasterized)

ちなみに最初にimagemagickを使う方法を試したが、解像度の問題か一部がモザイクのような状態になってしまったので見送っている。

- [画像を白黒化するコマンド(magick) - それマグで！](https://takuya-1st.hatenablog.jp/entry/2013/09/09/132400)
