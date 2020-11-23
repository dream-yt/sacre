---
title: "sedでファイル内の特定文字列を正規表現で書き換えたい/消したい時"
slug: sed-inplace-replace
date: 2020-11-17T08:04:28+09:00
draft: false
author: sakamossan
---

## 書き換えたい時

```bash
$ sed -i "" -e 's/http:\/\/dynamodb:8000/http:\/\/localhost:7800/' path/to/targetfile
```

- `-i` オプション
    - 出力内容をここで指定したパスに書き出す
    - 空文字 `""` を指定すると元のファイルを書き換える挙動になる


## 消したい時

```bash
$ sed -i"" -e '/192.168.88.19/d'  ~/.ssh/known_hosts
```

- `/d` オプション
    - マッチする行を消す動作になる
    - 空行になるのではなく、改行ごと消える
