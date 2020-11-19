---
title: "Sed Inplace Replace"
date: 2020-11-17T08:04:28+09:00
draft: false
author: sakamossan
---


## sedでファイル内の特定文字列を正規表現で書き換えたい時

sed -i "" -e 's/http:\/\/dynamodb:8000/http:\/\/localhost:7800/' path/to/targetfile

- `-i` オプション


- `/d` オプション

```bash
sed -i"" -e '/192.168.88.19/d'  ~/.ssh/known_hosts
```