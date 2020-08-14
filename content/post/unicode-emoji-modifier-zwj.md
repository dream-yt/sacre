---
title: "emojiで肌とか性別とか髪の色が変えられる仕組み"
date: 2020-08-06T12:05:18+09:00
draft: false
author: sakamossan
---

unicodeでは肌の色を変えられる仕組みが2015年から入っている。これは `skin tone modifiers` と呼ばれるもので、結合文字のようにベースとなる絵文字の後ろにコードポイントを従えることで実現している

```
$ node
> "\u{1F466}"
'👦'
> "\u{1F466}\u{1F3FE}"
'👦🏾'
```

## Zero Width Joiner (ZWJ)

Zero Width Joiner (ZWJ) という仕組みがあり、これは複数の絵文字を1文字にまとめるための仕組み。emojiの人物の性別を変えたり、カップルの性別を指示したりとかはこの仕組みを使っている


## 参考

- [Emoji Modifiers and Sequence Combinations](https://eng.getwisdom.io/emoji-modifiers-and-sequence-combinations/)


## 仕様

- [Full Emoji Modifier Sequences, v13.0](https://unicode.org/emoji/charts/full-emoji-modifiers.html)
- [UTS #51: Unicode Emoji](http://unicode.org/reports/tr51/)
