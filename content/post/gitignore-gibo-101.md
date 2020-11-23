---
title: "gitignoreを生成してくれるgiboを使う"
slug: gitignore-gibo-101
date: 2020-08-29T12:29:04+09:00
draft: false
author: sakamossan
---

giboは .gitignoreファイルを生成するソフトウェア
`VSCode` や `Node`、 `Rails` などを引数で指定してそのプロジェクトに必要そうなgitignoreを精製してくれる

- [simonwhitaker/gibo: Easy access to gitignore boilerplates](https://github.com/simonwhitaker/gibo)

brewで入る

```console
$ brew install gibo 
```

```console
$ gibo help
gibo 2.2.4 by Simon Whitaker <sw@netcetera.org>
https://github.com/simonwhitaker/gibo

Fetches gitignore boilerplates from https://github.com/github/gitignore

Usage:
    gibo [command]

Example:
    gibo dump Swift Xcode >> .gitignore

Commands:
    dump BOILERPLATE...   Write boilerplate(s) to STDOUT
    help                  Display this help text
    list                  List available boilerplates
    root                  Show the directory where gibo stores its boilerplates
    search STR            Search for boilerplates with STR in the name
    update                Update list of available boilerplates
    version               Display current script version
```

## list

`gibo list` で何向けのgitignoreが生成できるかの一覧がみられる

```
$ gibo list
Cloning https://github.com/github/gitignore.git to /Users/sakamossan/.gitignore-boilerplates
Cloning into '/Users/sakamossan/.gitignore-boilerplates'...
remote: Enumerating objects: 8935, done.
remote: Total 8935 (delta 0), reused 0 (delta 0), pack-reused 8935
Receiving objects: 100% (8935/8935), 2.05 MiB | 1.22 MiB/s, done.
Resolving deltas: 100% (4842/4842), done.
Actionscript
Ada
Agda
Android
AppceleratorTitanium
AppEngine
ArchLinuxPackages
Autotools
C++
C
```

データを `https://github.com/github/gitignore` から取得しているので、久しぶりに使う場合などは `gibo update` を叩いておくと良いようだ

```console
$ gibo update
From https://github.com/github/gitignore
 * branch            master     -> FETCH_HEAD
Already up to date.
```

## search

searchで部分一致してるboilerplateを探してくれる

```console
$ gibo search code
CodeIgniter
CodeKit
CodeSniffer
VisualStudioCode
Xcode
```

## dump

生成するコマンドは `gibo dump`
標準出力に出てくるのでシェルのリダイレクトなどをつかってファイルに落とす

boilerplate は幾つ指定してもいいようだ

```
$ gibo dump VisualStudioCode Node >> .gitignore
```
