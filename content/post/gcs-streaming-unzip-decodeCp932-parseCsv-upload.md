---
title: "Gcs Streaming Unzip DecodeCp932 ParseCsv Upload"
slug: gcs-streaming-unzip-decodeCp932-parseCsv-upload
date: 2021-12-29T14:49:59+09:00
draft: false
author: sakamossan
---

こんな要件のデータ連携があるとする。

## 要件

- 先方がGCPのCloudStorage(S3みたいなやつ)にファイルを置いてくれる
- 数GBくらいのShift-JISエンコードされたCSVファイル
- なぜか、ファイルはディレクトリに入った状態で、ディレクトリがzip圧縮されている

受け取ったデータはBigQueryに入れる。

- CSVのヘッダ行は `受付番号` とかなので、そのままだと使えない
- CSVからJSONLines形式に変換してBigQueryに入れる。
  - [Cloud Storage からの JSON データの読み込み  |  BigQuery  |  Google Cloud](https://cloud.google.com/bigquery/docs/loading-data-cloud-storage-json)
  - gzipすると読み込み速度が極端に落ちるとのことでgzipはしない
- その他、もらったCSVに対してバリデーションもしたい


## 実装方針

サーバ管理をしたくなかったので Cloud Function を使うことにしたいが、ファイル容量が数GBあるため、いったん全部解凍はメモリが足りなくてできない。nodejsのstreamで処理をすることにした。

- GCS上のファイルからStreamで読み出し
- zipなので解凍。出てきたディレクトリから目的のファイルの内容を読み出す
- ファイルがShift-JISエンコードなのでデコード
- CSVをパース
- バリデーション処理。不正な行はログを出してスキップ
- GCS上のファイルへ書き出し(ここもStream)


## 実装

こんな実装になった。ライブラリを組み合わせるだけで、自前で実装している部分はほとんどない。

```ts
import unzip from "unzipper";
import iconv from "iconv-lite";
import { parse as parseCsv } from "fast-csv";

const fn = async (srcGcsFile, destGcsFile, validator: any, tranform: any) => 
  srcGcsFile
    .createReadStream()
    .pipe(unzip.Parse())
    .on("entry", async (entry) => {
      const dest = destGcsFile.createWriteStream();
      entry
        .pipe(iconv.decodeStream("cp932"))
        .pipe(parseCsv({ headers: true }))
        .on("data", (data: any) => 
          validator(data) 
            ? dest.write(JSON.stringify(tranform(data)) + "\n")
            : console.error(`INVALID_ROW:${JSON.stringify(data)}`)
        );
    })
    .promise()
```

## unzipper

- [ZJONSSON/node-unzipper: node.js cross-platform unzip using streams](https://github.com/ZJONSSON/node-unzipper#readme)

zipファイルをdecompressしてくれるライブラリ。

`unzip` というライブラリがあったのだが、メンテナンスされなくなったのでforkされたものである。

zipをstreamでの読み出すのに対応しているが、そもそもzipファイルは複数ファイルを内包できる仕様になっているので、ファイルごとに`on('entry')`イベントが呼ばれるインターフェイスになっている。ファイルが複数入っているようなzipファイルの場合は`on('entry')`が何回も呼ばれる。

本来だと `entry` オブジェクトに生えているファイル名から目当てのファイルであるかチェックしてから処理をしたり、不要なファイルでは `autodrain` を呼んで内容を破棄する必要があるようだ。今回は1ファイルしかないはずなのでそのへんのケアは不要だった。


## iconv-lite

- [ashtuchkin/iconv-lite: Convert character encodings in pure javascript.](https://github.com/ashtuchkin/iconv-lite)

nodejsのビルトインの機能でstreamされる文字列をdecodeするのが面倒そうだったのでライブラリをつかっている。特別使い方に癖はなく `pipe` するだけでdecodeされる。


## fast-csv

- [C2FO/fast-csv: CSV parser and formatter for node](https://github.com/C2FO/fast-csv)

csvをstream処理してくれるという、今回のにぴったりなライブラリ。

`headers` オプションをつけるとヘッダ行のカラム名からオブジェクトを生成してくれる。1行パースするごとに`on('data')`イベントが呼ばれるので、そこにやりたい処理を挟めばよい。



## その他

GCSの nodejs クライアントはファイルオブジェクトに `createWriteStream` と `createReadStream` が生えているのでstreamでの読み込みと書き込みはそこからできる。

- [File#createReadStream](https://googleapis.dev/nodejs/storage/latest/File.html#createReadStream)
- [File#createWriteStream](https://googleapis.dev/nodejs/storage/latest/File.html#createWriteStream)

