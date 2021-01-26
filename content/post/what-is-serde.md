---
title: "athena(presto)のテーブル定義に出てくるSerdeとは?"
slug: what-is-serde
date: 2021-01-26T22:07:33+09:00
draft: false
author: sakamossan
---

athena(hive)のテーブル定義で出てくる。`JsonSerDe`みたいなもの。

```sql
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
WITH SERDEPROPERTIES (
  'serialization.format' = '1'
) LOCATION 's3://bucketistyu/data/'
```

調べたらシリアライザ(SERializer) / デシリアライザ(DESerializer) の略だった。

- [SerDes - Wikipedia](https://ja.wikipedia.org/wiki/SerDes)

言われてみればそうだよね。と思いました。
