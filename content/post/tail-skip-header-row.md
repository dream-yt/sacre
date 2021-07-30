---
title: "tail コマンドで1行目をスキップする"
slug: tail-skip-header-row
date: 2021-07-30T12:23:08+09:00
draft: false
author: sakamossan
---

こんなファイルがあるとして、ヘッダ行の `id` だけ取り除きたいという場合。

```console
$ cat /tmp/_
id
1
2
3
```

tail コマンドでできる。

```console
$ cat /tmp/_ | tail -n +2
1
2
3
```

tailコマンドは `-n` オプションに `+{{数}}` という引数を渡してあげると「N行目以降を表示する」というモードになる。
