---
title: "curlでURLが200以外を返した場合にシェルの終了コードを1以上にする"
slug: curl-exitcode-gt1-on-404
date: 2021-01-24T11:02:50+09:00
draft: false
author: sakamossan
---

`--fail` をつければよい

こんなコマンドでURLが200を返すかどうか確認するだけのコマンドになる

```
$ curl --silent --fail --output /dev/null --head {{ URL }}
```

## 参考

- [stdout - Can I make cURL fail with an exitCode different than 0 if the HTTP status code is not 200? - Super User](https://superuser.com/questions/590099/can-i-make-curl-fail-with-an-exitcode-different-than-0-if-the-http-status-code-i)
