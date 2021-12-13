---
title: "apache bench でリクエストに指定のヘッダをつける"
slug: apache-bench-request-header
date: 2021-12-13T17:59:21+09:00
draft: false
author: sakamossan
---

たとえば Authorization ヘッダだとこんな感じでつけられる。

```bash
$ ab -n 10 -c 1 -H "Authorization: Bearer xxxxxxxx" "https://example.com/test"
```

## ヘッダ

`-H` オプションで設定できる。

```
    -H attribute    Add Arbitrary header line, eg. 'Accept-Encoding: gzip'
```

## その他

そのほか最低この2つのオプションがわかっていれば、ざっくりとした確認はできる。

```
    -n requests     Number of requests to perform
    -c concurrency  Number of multiple requests to make at a time
```

