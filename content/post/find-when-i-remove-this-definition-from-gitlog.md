---
title: "git で定義がいつ消されたかを log から検索する"
slug: find-when-i-remove-this-definition-from-gitlog
date: 2021-08-16T17:29:06+09:00
draft: false
author: sakamossan
---

たとえば package.json から puppeteer を取り除いたのはいつだったかなと調べたいときがある。
もう消えてしまっている文字列は grep では探せないが、git は知っている。 

`-S` オプションで探してくれる。

```
$ git log -S {{ 探したい文字列 }} ./探したいファイル
```

```
-S<string>
    Look for differences that change the number of occurrences of the specified string (i.e. addition/deletion) in a file. Intended for the scripter's use.

    It is useful when you're looking for an exact block of code (like a struct), and want to know the history of that block since it first came into being: use the feature iteratively to feed the interesting block in the preimage back
    into -S, and keep going until you get the very first version of the block.

    Binary files are searched as well.
```

### 例

たとえば `puppeteer` の依存を取り除いたのはいつだったかなと探すときはこんな感じで探せる。

```
$ git log -S puppeteer ./package.json
commit 0f1010450322779aa3b77db6bfe36260e0e92a91
Author: sakamossan <mild7caloriemategreentea@gmail.com>
Date:   Tue Apr 28 13:49:38 2020 +0900

    [#5021] remove mocha

commit 2aaad15ac13d872cc3fc4051a063946ab7d4808f
Author: sakamossan <mild7caloriemategreentea@gmail.com>
Date:   Tue Mar 13 18:46:21 2018 +0900

    [#1609] add mocha
```

コミットがわかればそこから git show したりチケット番号で検索したりできる。

## 参考

- [Git - git-log Documentation](https://git-scm.com/docs/git-log#Documentation/git-log.txt--Sltstringgt)
