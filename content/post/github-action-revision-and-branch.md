---
title: "GitHub Action で実行中のブランチ名とリビジョンを出す"
slug: github-action-revision-and-branch
date: 2020-12-27T23:34:21+09:00
draft: false
author: sakamossan
---

こんな感じで出力できる。

```yaml
- name: Show Revision
  run: |
    echo -e "Branch: ${GITHUB_REF##*/}"
    echo -e "Revision: ${GITHUB_SHA:0:8}"
```

## 参考

- [git - Getting current branch and commit hash in GitHub action - Stack Overflow](https://stackoverflow.com/questions/58886293/getting-current-branch-and-commit-hash-in-github-action)
