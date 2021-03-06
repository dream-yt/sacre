---
title: "VLOOKUPの使い方をメモ"
slug: spreadsheet-vlookup
date: 2019-01-23T09:40:35+09:00
draft: false
author: sakamossan
---

自分で使ったことがなかったので勉強

## 概要

指定した表のなかから条件にマッチした行の、指定したカラムの値を返してくれる

> VLOOKUP(検索キー, 範囲, 番号, [並べ替え済み])

ドキュメントの具体的な使い方が分かりやすかった

- [VLOOKUP - ドキュメント エディタ ヘルプ](https://support.google.com/docs/answer/3093318?hl=ja)


## それぞれの引数の意味

- 範囲
    - 検索をかけるテーブル
    - 一番左のカラムがwhere句の比較対象になっている
- 番号
    - とってくるカラム
- 検索キー
    - 範囲の一番左のカラムと付き合わせる値
- 並べ替え済み
    - 範囲がソート済みだと便利な場合があるらしい
    - 慣れてきたら使い方調べる


1カラムごとにこんなSQLがフェッチしてくれるイメージだろうか

```sql
select 範囲.番号
from 範囲
where 範囲.一番左のカラム = 検索キー
```

以下のあたり引数名から自明でないような...

- `検索キー`が検索するのは、`範囲.一番左`のカラムから検索する
- `番号`ってのは`範囲`の中からカラム左から何個目、という指定


## 相対参照/絶対参照

`=A1` みたいな式を下(行の)方向にコピペすると `=A2` のようによしなに行の数値を増やしてくれるが、
これは相対参照の働き。VLOOKUPの`検索範囲`の部分は固定の表を参照したいはずなので絶対参照にする
(絶対参照にするとコピペしてもよしなに範囲をずらしたりしなくなる)

#### 絶対参照にしかた

固定したいほうの前に`$`をつけると絶対参照になる

- `=$A1` 列方向は固定
- `=A$1` 行方向は固定
- `=$A$1` 両方固定
