---
title: "gitconfig alias の '!' の意味"
slug: git-config-alias-prefixed-bang
date: 2021-01-27T11:48:27+09:00
draft: false
author: sakamossan
---

aliasを設定する時の `!` は「以下をシェルコマンドとして扱って」という意味。

### 例

パイプもできる

```bash
$ git config --global alias.ack '! git ls-files --others --cached --exclude-standard | ack -x'
```

この例はgit管理されてるファイルからackで検索するというもの


### ドキュメント

> If the alias expansion is prefixed with an exclamation point, it will be treated as a shell command. 

- [Git - git-config Documentation](https://git-scm.com/docs/git-config#Documentation/git-config.txt-alias)


### 参考

例の元ネタ

- [Add `git ack` alias to docs somewhere · Issue #330 · beyondgrep/ack3](https://github.com/beyondgrep/ack3/issues/330)
