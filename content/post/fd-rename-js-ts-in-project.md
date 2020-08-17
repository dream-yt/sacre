---
title: "fdでsrc配下のjsファイルをtsに一括でrenameする"
date: 2020-08-17T17:07:35+09:00
draft: false
author: sakamossan
---

fdを使うとこんな塩梅になる

```bash
fd --glob '*.js' ./src --exec mv {//}/{/.}.js {//}/{/.}.ts
```

- `--glob '*.js'`
  - jsファイルのみを対象にする
- `./src`
  - ファイルを探すパス
- `--exec mv {//}/{/.}.js {//}/{/.}.ts`
  - 見つかったファイル1つ1つに対して処理を実行する


## `{//}/{/.}.js {//}/{/.}.ts`

`{//}`みたいなのはプレースホルダーであり、このように置換される

- `{//}` がディレクトリ名
- `{/.}` がファイル名

helpでいつでもみられる

```
$ fd --help | grep -A7 '\-\-exec '
    -x, --exec <cmd>
            Execute a command for each search result.
            All arguments following --exec are taken to be arguments to the command until the argument ';' is encountered.
            Each occurrence of the following placeholders is substituted by a path derived from the current search result before the command is executed:
              '{}':   path
              '{/}':  basename
              '{//}': parent directory
              '{.}':  path without file extension
              '{/.}': basename without file extension

```
