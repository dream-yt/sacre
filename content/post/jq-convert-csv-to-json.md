---
title: "jq で CSV を JSON に変換する"
slug: jq-convert-csv-to-json
date: 2022-01-30T14:23:12+09:00
draft: false
author: sakamossan
---

こんなCSVをJSONにする。

```csv
1,foo
2,bar
```

id,name の2カラムのCSVとみなすとこのようになる。

```bash
$ cat /tmp/_ \
    | jq --raw-input 'split(",") | {id: .[0], name: .[1]}' \
    | jq -s
```

```json
{
  "id": "1",
  "name": "foo"
}
{
  "id": "2",
  "name": "bar"
}
```

`--raw-input` がミソになっていて、これをつけないと不正な入力として扱われる。 `--raw-input` をつけると文字列として扱われるので `split` などの関数でハンドリングすることができる。
