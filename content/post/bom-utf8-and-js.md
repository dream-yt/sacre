---
title: "BOMつきUTF-8とjsについて"
date: 2020-10-13T12:14:06+09:00
draft: false
author: sakamossan
---

まずBOMについて

- [バイトオーダーマーク - Wikipedia](https://ja.wikipedia.org/wiki/%E3%83%90%E3%82%A4%E3%83%88%E3%82%AA%E3%83%BC%E3%83%80%E3%83%BC%E3%83%9E%E3%83%BC%E3%82%AF)

BOMとはもともとはリトルエンディアンとビッグエンディアンのどちらかを判別するためにファイルの先頭につくバイト列のこと。

本来はUTF-8ではエンディアンにかかわらず同じ内容となるようだが、エクセルなどで開くときにBOMがついていないと文字化けしてしまうことがあるので、エクセルで読まれる前提のcsvファイルなどはBOMつきUTF-8を生成する必要がある

## BOM付きか否かの確認方法

odで確認できる

```console
$ head -1 ~/_.csv | od -t x1
0000000    ef  bb  bf  e3  83  a1  e3  83  87  e3  82  a3  e3  82  a2  49
0000020    44  2c  e3  83  a1  e3  83  87  e3  82  a3  e3  82  a2  2c  e5
0000040    aa  92  e4  bd  93  e7  a4  be  49  44  2c  e5  aa  92  e4  bd
```

fileコマンドでも `(with BOM)` の有無で確認できる

```console
$ file ./*.csv
/tmp/_.csv: UTF-8 Unicode (with BOM) text
```

## jsでBOMをつける方法

csvをダウンロードさせるとして、blobを生成するときに先頭にBOMのバイト列をつけてやればよい

```js
const bom = new Uint8Array([0xef, 0xbb, 0xbf]);
const blob = new Blob([bom, str], {type: 'application/octet-stream'});
```

単純に `"\uFEFF"` を連結するだけでも動作するようだ

```js
const bom = "\uFEFF";
const blob = new Blob([bom, str], {type: 'application/octet-stream'});
```


## 参考

- 
- [【メモ】コマンドでのBOMの追加・削除・確認 - Qiita](https://qiita.com/tamanugi/items/63fe5cf8e709565777a5)