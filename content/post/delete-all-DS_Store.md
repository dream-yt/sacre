---
title: "一発で.DS_Storeをすべて削除する"
slug: delete-all-DS_Store
date: 2021-04-28T10:22:18+09:00
draft: false
author: sakamossan
---

findコマンドでできる

```bash
$ find . -name ".DS_Store" -print -delete
```
