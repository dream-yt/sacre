---
title: "jq で parseInt"
slug: jq-parseInt
date: 2019-09-28T12:26:35+09:00
draft: false
author: sakamossan
---

jqで文字列から数値に変換したいときは `tonumber` 関数を使う


## 例

こんな感じで使える

- `select` 関数で条件に合うものだけにフィルタ
  - IDが文字列で `5` から始まるもの
  - 数値比較でランキングが3以下のもの
- `jq -s .` でまた配列に戻している
- sponge コマンドを使って元のファイルに書き出し

```bash
$ cat /tmp/_.json \
  | jq '.[] 
    | select(.id|test("^5")) 
    | select((.ranking|tonumber) <= 3)' \
  | jq -s . \
  | sponge /tmp/_.json
```


## 参考

- [casting - How to convert a string to an integer in a JSON file using jq? - Stack Overflow](https://stackoverflow.com/questions/48887711/how-to-convert-a-string-to-an-integer-in-a-json-file-using-jq)
- [jq Manual (development version) | tonumber](https://stedolan.github.io/jq/manual/#tonumber)

