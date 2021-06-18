---
title: "seq の出力を printf 形式でフォーマットする -f オプション"
slug: seq-format-option
date: 2021-06-18T14:26:22+09:00
draft: false
author: sakamossan
---

こんな文字列が欲しい時。

```
2021-06-01
2021-06-02
2021-06-03
2021-06-04
2021-06-05
2021-06-06
2021-06-07
2021-06-08
2021-06-09
2021-06-10
```

いままでは seq に xargs をパイプしたりしていたが、seq にフォーマットオプションがあることを知ったのでそれを使う。

```bash
for d in $(seq --format '2021-06-%02g' 10); do
    echo $d
done
```

## 参考

`%02d` が使えなかったので検索したらこれが出てきた。やりとりの意味が掴めなかったが、`--equal-width` があるから不要なはず。ということなのかな。

- [231206 – seq considers format "%02d" illegal](https://bugzilla.redhat.com/show_bug.cgi?id=231206)
