---
title: "hive(athena)の InputFormat, OutputFormat, SerDe"
date: 2020-04-18T13:01:07+09:00
draft: false
---

hive の create table は次のようなものである

```sql
CREATE TABLE test(id INT, name STRING) 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe' 
STORED as INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat' OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
```

このなかの SERDE, INPUTFORMAT, OUTPUTFORMAT についてメモ


## INPUTFORMAT, OUTPUTFORMAT

hive には external storage と hive warehouse 2種類のデータストアがある

これらのストアされたデータの形式はcsvからparquetまで色んなものが使えるが、どのデータ構造でストアされているかを InputFormat, OutputFormat にて定義しておく

- データを読みだすときには InputFormat の定義が使われ
- データを書き出すときには OutputFormat の定義が使われる

### SerDe

Deserializer, Serializer のこと

InputFormat によって 読みだしたファイルのレコードをどのようにパースしてRowオブジェクトにするかを定義するのが Deserializer であり、同様に結果のRowをどうシリアライズするかが Serializer である


## 参考

- [hadoop - What is the difference between 'InputFormat, OutputFormat' & 'Stored as' in Hive? - Stack Overflow](https://stackoverflow.com/questions/42416236/what-is-the-difference-between-inputformat-outputformat-stored-as-in-hive)
- [Structuring Hadoop data through Hive and SQL – Diving into Hadoop](https://oyermolenko.blog/2017/02/16/structuring-hadoop-data-through-hive-and-sql/)
