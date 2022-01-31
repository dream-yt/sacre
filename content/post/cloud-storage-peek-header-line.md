---
title: "CloudStorage にある大きなCSVファイルのヘッダ行だけ読む"
slug: cloud-storage-peek-header-line
date: 2022-01-30T11:41:18+09:00
draft: false
author: sakamossan
---

gsutil cat というサブコマンドがあり、指定したバイト数だけ読み出すことができる。

- 先頭から20キロバイトくらい(1行以上読めるくらいの量)を読み出して
- `head -1` で先頭1行だけ取り出す

```bash
$ gsutil cat -r 0-20000 gs://mybucket/test/dest/_/tablename/2021/05.csv \
    | head -1 \
    | perl -pe 'tr/,"\r/\n/d' \
    > ./original/$tablename.txt
```


## 参考

- [cat - Concatenate object content to stdout  |  Cloud Storage  |  Google Cloud](https://cloud.google.com/storage/docs/gsutil/commands/cat)
