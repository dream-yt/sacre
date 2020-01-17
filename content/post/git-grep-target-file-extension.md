---
title: "git grepで探すファイルの拡張子を指定"
date: 2020-01-17T11:35:48+09:00
draft: false
---

こんな感じでできる

```console
$ git grep cache -- '*.java'
```

git grepでは `--` 以降が対象パスの指定となっているので、そこにglobを書くと探索するファイルを指定できる

> -- <pathspec>…​
> Signals the end of options; the rest of the parameters are <pathspec> limiters.

ちなみにexcludeするときは以下のように書くようだ

```console
$ git grep solution -- :^Documentation
```

> Looks for solution, excluding files in Documentation.

### 参考

- [git grep by file extensions - Stack Overflow](https://stackoverflow.com/questions/13867705/git-grep-by-file-extensions)
- [Git - git-grep Documentation](https://git-scm.com/docs/git-grep#Documentation/git-grep.txt-ltpathspecgt82308203)

