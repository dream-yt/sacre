---
title: "いまのブランチでいじってるファイルをいっぺんにvscodeで開く"
slug: git-branch-diff-files-open-vscode
date: 2018-12-06T14:25:18+09:00
draft: false
author: sakamossan
---

なお、ブランチはmasterから派生させている前提

## コマンド全体

最初にmasterから分岐した箇所のコミットハッシュを取得している

```bash
BASE=$(git show-branch --merge-base master HEAD); git diff $BASE HEAD --name-only | xargs code
```

#### いまいるブランチはどこでmasterから分岐しているか

```bash
git show-branch --merge-base master HEAD
```

#### いじったファイルの一覧

```bash
git diff $BASE HEAD --name-only
```

#### ファイル一覧をそれぞれvscodeで開く

```bash
| xargs code
```

### 参考

- [2つのブランチの分岐点をみつけるgit show-branch --merge-base - Qiita](https://qiita.com/awakia/items/ed53f4aada688f7f19a9)
