---
title: "元祖からforkしてきたリポジトリに元祖の最新のコードを取り込む"
slug: merge-upstream-onto-forked-repos
date: 2021-10-04T15:12:48+09:00
draft: false
author: sakamossan
---

リポジトリをまたぐときはこのようにしてpullできる

```bash
$ cd github.com/myname/bar
$ git pull git@github.com:foo/bar.git master
```

`master` はブランチ名なので `main` などになっていたら適宜変更する。

## 参考

- [上流リポジトリをフォークにマージする - GitHub Docs](https://docs.github.com/ja/github/collaborating-with-pull-requests/working-with-forks/merging-an-upstream-repository-into-your-fork)
