---
title: "一定期間で自分がGitHubでマージしたブランチを取得する"
slug: gitlog-mymerge
date: 2019-11-13T12:33:01+09:00
draft: false
author: sakamossan
---

こんな感じ

```bash
$ git log \
  --format='%h %an (%ai) %s' 
  --since='2019-10-25' \
  --author=sakamossan \
  --grep='Merge pull request #\d+' -P
```

こんな出力が得られる

```
3fc6ed727 sakamossan (2019-11-11 14:04:54 +0900) Merge pull request #4573 ...
87daf1614 sakamossan (2019-11-06 17:59:30 +0900) Merge pull request #4557 ...
47e68edfc sakamossan (2019-11-06 11:22:41 +0900) Merge pull request #4542 ...
```


### --format='%h %an (%ai) %s'

出力フォーマットの指定

- `%h`
  - abbreviated commit hash
- `%an`
  - auther name
- `%ai`
  - author date, ISO 8601-like format
- `%s`
  - subject 

全部のプレースホルダーからここで見られる

- [Git - pretty-formats Documentation](https://git-scm.com/docs/pretty-formats)


### --author=sakamossan

authorでフィルタ

### --since='2019-10-25'

2019年10月25日以降のコミットログのみが表示される


### --grep='Merge pull request #\d+' -P

- `--grep='Merge pull request #\d+'`
  - 指定した文字列/パターンでgrep
- `-P`
  - grepするパターンにperl互換の正規表現を使う
  - `\d+` を使うために指定している
