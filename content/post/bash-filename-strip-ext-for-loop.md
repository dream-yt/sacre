---
title: "bashで、ディレクトリ配下のファイル名から拡張子を取り除いてforループする"
slug: bash-filename-strip-ext-for-loop
date: 2022-01-22T14:46:58+09:00
draft: false
author: sakamossan
---

こんな感じでできる。

```bash
for _ in $(ls -1 ./some-directory/*.txt | xargs basename -s .txt); do
    echo $_
done
```

- `ls -1 ./some-directory/*.txt`
    - ディレクトリからファイル名だけを取り出す
- `xargs basename -s=.txt`
    - ファイル名から `.txt` 拡張子を取り除く

