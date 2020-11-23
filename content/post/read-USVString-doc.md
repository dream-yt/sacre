---
title: "Unicodeスカラー値と、対になっていないサロゲートコードポイントについてメモ"
slug: read-USVString-doc
date: 2020-10-13T14:38:36+09:00
draft: false
author: sakamossan
---

この文章がよく分からなかったので単語について調べたときのメモ

[USVString - Web API | MDN](https://developer.mozilla.org/ja/docs/Web/API/USVString)

> USVString は、Unicode スカラー値（unicode scalar values）のすべての可能なシーケンスの集合に対応します。 USVString は、JavaScript で返されると String にマップされます。 通常、テキスト処理を実行し、操作するために Unicode スカラー値の文字列が必要な API にのみ使用されます。 USVString は、対になっていないサロゲートコードポイント（surrogate codepoints）を許可しないこと以外は DOMString と同じです。 USVString にある対になっていないサロゲートコードポイントは、ブラウザーによって Unicode の置換文字（replacement character）U+FFFD (�) に変換されます。

## Unicode スカラー値

Unicodeはコードポイントの定義の集合で、それぞれのコードポイントを `U+10FFFF` といったリテラルで表すこと

> 文字セットは16進数にU+をつけて U+0000～U+10FFFF で表します。これをUnicodeスカラ値といいます。

```console
$ node -p '"\u{1F466}"'
👦
$ node -p '"\u{1F466}\u{1F3FE}"'
👦🏾
```

`U+4E00` といった表現はutf8など、エンコーディングの世界の表記ではなく文字集合であるUnicodeの世界の表現である。このリテラルはUnicodeの符号位置を示すためのものである。jsで使える `\u{1F466}` といったリテラルは符号位置をASCIIで入力したものである。

- [Unicode](https://seiai.ed.jp/sys/text/csd/cf14/c14a070.html#:~:text=%E7%A7%81%E7%94%A8%E9%9D%A2-,Unicode%E3%82%B9%E3%82%AB%E3%83%A9%E5%80%A4,U%2BFFFF%20%E3%81%A8%E8%A1%A8%E3%81%97%E3%81%BE%E3%81%99%E3%80%82)


## 対になっていないサロゲートコードポイント

文字を示すバイト列として不完全になっているもののことを言っている

### まずサロゲートペアについて

まずUnicodeは符号位置の集合であり、UTF-8・UTF-16・UTF-32 といったUnicodeに対応するエンコーディングは文字をどんなバイト列で表現するかの規格である。符号位置はコードポイントとも呼ばれる。

> Unicodeには、16ビットすなわち65,536の符号位置を持つ面（plane）が17面あり、合計100万あまりの符号位置を持ちます。符号位置は「U+4E00」のように接頭辞「U+」を付けた4〜6桁の16進数で表記します。

> 17面あるうち、最初の面00が基本多言語面（BMP、Basic Multilingual Plane）であり、日常的に用いる文字の大半がここに収められています。

UTF-16ではBMPの範囲外の文字列は16ビットで表さずに32ビットを使う。そしてJavaScriptでは文字列はUTF-16である。

> JavaScript の文字列 は、UTF-16 でエンコードされた文字列です。

この32ビットで1文字をあらわすための仕組みがサロゲートペアである。

- [バイナリー文字列 - Web API | MDN](https://developer.mozilla.org/ja/docs/Web/API/DOMString/Binary)
- [文字コード再入門](https://employment.en-japan.com/engineerhub/entry/2020/04/28/103000#%E3%82%B5%E3%83%AD%E3%82%B2%E3%83%BC%E3%83%88%E3%83%9A%E3%82%A2)


### 次にサロゲートコードポイントについて

サロゲートペアの1文字目のこと。サロゲートペアを表現するときの片側のバイトが指す符号位置のこと。U+D800 ～ U+DFFFがそれにあたり、16ビット配下だがこの範囲にはBMPに文字が収録されていない。

> BMP以外のU+10000..U+10FFFFは、表のようにビットを配分して、符号単位2つで表す。

> このとき使われる、U+D800 ～ U+DFFF の符号位置を、代用符号位置（Surrogate Code Point）と呼び、BMP外の1つの符号位置を表す連続した2つの代用符号位置のペアをサロゲートペアと呼ぶ。代用符号位置に使うため、BMPのこの領域には文字が収録されておらず、UTF-16以外のUTF-8、UTF-32では使用されない。

- [UTF-16 - Wikipedia](https://ja.wikipedia.org/wiki/UTF-16)
