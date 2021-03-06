---
title: "mp4のatomとは"
slug: mp4-atom-fast-start
date: 2020-08-13T17:03:54+09:00
draft: false
author: sakamossan
---

- atomとはmp4ファイルを構成する要素
- atomはboxとも呼ばれる

メタデータもコンテンツもatomに格納されている

- ftyp: このmp4ファイルが準拠している規格 (eg: mp42, m4v, isom)
- moov: メディア/トラックごとのヘッダ情報
  - 例:
    - 動画のDuration
    - 音声のビットレート
- mdat: メディアファイル本体


## fast start とは

web経由で動画を再生する場合、ファイル内のatomの配置を工夫する必要がある

#### 前提

- moovは動画の長さやビットレートなどのヘッダ情報
- mdatはメディアファイル本体

動画ファイルを作成する時は以下の順番になり、
ファイル内でヘッダ情報(moov)がメディア情報(mdat)より後ろに配置される

1. メディアファイルができあがる
2. 動画の長さやビットレートがわかるので、ヘッダ情報に入れる

インターネット経由で動画を再生する場合などはファイルを先頭からダウンロードしながら再生したいため、ファイルの先頭にヘッダ情報が含まれている必要がある

このヘッダ情報をメディア情報より先に配置することを fast start という


## 参考

- [unoh.github.com by unoh](https://unoh.github.io/2007/09/12/mp43gpp3gpp2.html)
- [profile？atom？mp4のよくわからないあれこれ（atom編) | DACエンジニアブログ：アドテクゑびす界](http://yebisupress.dac.co.jp/2015/11/04/profile%EF%BC%9Fatom%EF%BC%9Fmp4%E3%81%AE%E3%82%88%E3%81%8F%E3%82%8F%E3%81%8B%E3%82%89%E3%81%AA%E3%81%84%E3%81%82%E3%82%8C%E3%81%93%E3%82%8C%EF%BC%88atom%E7%B7%A8/)
