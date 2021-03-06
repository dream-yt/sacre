---
title: "jq での変形例 (keys[]でのオブジェクト=>オブジェクト編) "
slug: jq-sample-keys-obj-children
date: 2018-11-03T17:45:49+09:00
draft: false
author: sakamossan
---

こんなjsonがあって

```json
{
  "xxxxxx": {
    "_name": "トーマス",
    "children": [
      {
        "name": "トーマス（男性向け）",
        "code": "41080"
      },
      {
        "code": "41081",
        "name": "トーマス（女性向け）"
      },
      {
        "code": "41082",
        "name": "トーマス（センシティブ）"
      }
    ]
  },
  "yyyyyy": {
    "_name": "古物商/リサイクル/オークション",
    "children": [
      {
        "name": "オークション/フリマ",
        "code": "7040"
      }
    ]
  }
}
```

こう変換したい (children配下のcodeの配列にしたい)

```json
{
  "xxxxxx": [
    "41080",
    "41081",
    "41082"
  ]
}
{
  "yyyyyy": [
    "7040"
  ]
}
```


## .jq

この変換はこんな感じのjqスクリプトで出来る

```
keys[] as $k | { ($k): [.[$k].children[].code] }
```

注意点といえるのは次の二つ

- `keys[] as $k | `
    - パイプ以降はそれぞれのキーごとのmap/foreachみたいな処理に出来る
    - `keys as $k` では`$k`に配列が入ってしまうのでちょっと違う
- `{ ($k):`
    - $変数は括弧で囲わないとオブジェクトのキーに出来ない



