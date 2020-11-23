---
title: "jqで変形 (オブジェクト => 配列 => オブジェクト)"
slug: jq-object-array-object
date: 2019-11-24T09:18:24+09:00
draft: false
author: sakamossan
---

こんなデータ構造のjsonがあるとして

```json
{
  "APP1": { "name": "旧App", "monId": 277013 },
  "APP2": { "name": "App", "monId": 241736 },
  "DB": { "name": "Database", "monId": 234737 },
  "S": { "name": "Static", "monId": 221738 }
}
```

この形式にjqで変換したい

```json
{
  "277013": "旧App",
  "241736": "App",
  "234737": "Database",
  "221738": "Static"
}
```

### 具体的には

こんなオブジェクトに変換したい

- `monId` をオブジェクトのキーに
- 値は `name` に


# jqで変換

スクリプトはこんな感じ

```bash
pbpaste | jq '. 
  | to_entries 
  | map({ (.value.monId|tostring): (.value.name) }) 
  | add '
```

- オブジェクトから `to_entries` でいっかい配列に
- 配列の各要素からキーとバリューをのセットを取得
- `map | add` で再度オブジェクトに変換


## to_entries

オブジェクトから配列に変換してくれる

### 例

この形を

```js
{
  "APP1": { "name": "旧App", "monId": 277013 },
  "APP2": { "name": "App", "monId": 241736 }
}
```

こうしてくれる

```js
$ pbpaste | jq '. | to_entries'
[
  {
    "key": "APP1",
    "value": {
      "name": "旧App",
      "monId": 277013
    }
  },
  {
    "key": "APP2",
    "value": {
      "name": "App",
      "monId": 241736
    }
  }
]
```


## map({ (.value.monId|tostring): (.value.name) }) | add

- オブジェクトのキーはstringな必要があるため `.value.monId|tostring`
- `map | add` は配列からオブジェクトへ変換するときに使う
  - 2つのオブジェクトをaddすると、オブジェクトのマージになる

#### add の例

```js
[
  {"a": 1},
  {"b": 2}
]
```

```js
$ pbpaste | jq '. | add'
{
  "a": 1,
  "b": 2
}
```
