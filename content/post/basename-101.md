---
title: "basename と末尾のスラッシュなど"
slug: basename-101
date: 2021-03-01T18:16:20+09:00
draft: false
author: sakamossan
---

basenameはシェルスクリプトとかでパスからファイル名を取り出す時に使う。
文字列が `/` で終端してるかどうかにかからわずうまいことやってくれるのが便利。

```bash
$ pwd .
/Users/sakamoto/apps/learn

# 末端部分を切り出す
$ basename /Users/sakamoto/apps/learn
learn

# / で終端してた場合は/を取り除いて取得
$ basename /Users/sakamoto/apps/
apps

# 存在しないファイルでもbasename出来る
$ basename /Users/sakamoto/apps/learn/READ
READ
```
