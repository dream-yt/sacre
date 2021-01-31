---
title: "pipeされた標準入力がseekできなかった話"
slug: python-seek-pipe-or-stdin
date: 2021-01-31T11:17:59+09:00
draft: false
author: sakamossan
---

こんなコードを書こうとした。

```py
if filepath == '-':
    fo = sys.stdin
else:
    fo = open(filepath, mode=read_mode)
```

ファイルパスの引数に `-` を渡したら標準入力の内容を使うというもの。

標準入力のシノニムとして `-` を使うコードは python の fileinput や awscli, gsutil にもあったものなのでいいかなと思ったのだが、後続の処理で `fo.seek(0)` が呼ばれてエラーになることがわかった。

```console
# pipeすると fo.seek(0) で IOError: [Errno 29] Illegal seek になる
$ cat /tmp/_.csv | ./csv2sqlite.py - /tmp/_.sqlite3
Traceback (most recent call last):
  File "./csv2sqlite.py", line 210, in <module>
    convert(args.csv_file, args.sqlite_db_file, args.table_name, args.headers, compression, args.types)
  File "./csv2sqlite.py", line 47, in convert
    fo.seek(0)
IOError: [Errno 29] Illegal seek
```

pythonのstdinが抽象化してくれていると勝手に思っていたが、調べてみるとpipeやsocket由来の標準入力はseekできないルールがちゃんとあり、そのルールに抵触しているのでエラーになっているようだった。

> If it's a terminal or a pipe or a socket, no. If it's a file, yes (usually).

- [can you seek() on STDIN](https://www.perlmonks.org/?node_id=255413)

OSにもよるのかもしれない (Linuxはダメ)

> Some devices are incapable of seeking and POSIX does not specify which devices must support lseek().

- [lseek(2): reposition read/write file offset - Linux man page](https://linux.die.net/man/2/lseek)


### ファイル由来の標準入力だとseekできる

```console
$ ./csv2sqlite.py - /tmp/_.sqlite3 < /tmp/_.csv
```
