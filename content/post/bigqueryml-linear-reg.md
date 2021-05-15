---
title: "BigQueryML で回帰分析をする"
slug: bigqueryml-linear-reg
date: 2021-05-15T14:22:29+09:00
draft: false
author: sakamossan
---

単回帰分析で済む単純な分析をするときに BigQueryML が便利だった。

## やりたいこと

オートインクリメントなユーザテーブルがあるとして、ユーザ ID からその登録時期を予測したいとして、どれくらい相関性があるのかをみたい。
もちろんユーザテーブルには登録日 ( `created` )も入っている。

## クエリを書く

2 カラムの結果を返すクエリを書く。今回は説明変数が user_id で、目的変数は created となるが、目的変数のカラム名を `label` にする必要がある。

```sql
SELECT created as label,
    user_id
FROM `pjt-123345.ds.users`
ORDER BY label
```

## create model する

クエリはそのまま `CREATE MODEL` を足す。今回は線系回帰を使うので `model_type = 'linear_reg'`

```sql
CREATE MODEL `misc.kaiki_sample` OPTIONS(model_type = 'linear_reg') AS
SELECT created as label,
    user_id
FROM `pjt-123345.ds.users`
ORDER BY label
```

## 結果を眺める

しばらくすると計算が終わる。モデルの `評価` タブをみると `決定係数` がみられる。
