---
title: "fdを使う"
date: 2020-02-26T16:34:33+09:00
draft: false
---

rustで GNU Core Utilities 実装してみたよシリーズであるところのfdコマンド


- [sharkdp/fd: A simple, fast and user-friendly alternative to 'find'](https://github.com/sharkdp/fd)

老害が嫌がりそうなプロジェクトで好感が持てます


### インストール

```bash
brew install fd
```

## 例

##### ~/.ghq ディレクトリ配下 node_modules 以外で .envrc ファイルを探す

```
$ fd '.envrc' ~/.ghq --no-ignore --exclude node_modules
```

#### test.js なファイルから grep する

findと同様 `{}` がプレースホルダになっている

```
$ fd test.js ./ --exec grep '.vue' {}
```

> --exec 
> Execute a command for each search result.
> All arguments following --exec are taken to be arguments to the command until the argument ';' is encountered.
> Each occurrence of the following placeholders is substituted by a path derived from the current search result before the command is executed:
> '{}':   path
> '{/}':  basename
> '{//}': parent directory
> '{.}':  path without file extension
> '{/.}': basename without file extension
