---
title: "vscode-settings-sync のトークン更新手順"
slug: vscode-settings-sync-token-refresh-memo
date: 2022-01-05T12:25:00+09:00
draft: false
author: sakamossan
---

GitHub のトークンが expire するたびにググっていたのでメモ。


## 経緯

vscode の設定の同期は、`vscode-settings-sync` を使っている。

- [Settings Sync - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync)
- [Visual Studio Code Settings Synchronization](http://shanalikhan.github.io/2015/12/15/Visual-Studio-Code-Sync-Settings.html)

一昨年くらいに公式から同様の拡張がでてきて旗色が悪そうだが、個人的には頑張ってほしいと思っている。設定を Gist で管理しているので他人にシェアするのが楽なのがときどき便利なので。

## 手順

トークンを取得

- [Personal Access Tokens](https://github.com/settings/tokens)
    - scope は gist のみでもいけた

vscode のコマンドパレットから以下のところでトークンを入力

- `Sync: Advanced Options`
    - `Sync: Open Settings`


### トークンのスコープについて

GitHub で払い出すトークンの scope は `gist` だけでも動くみたいである。

> gist	Grants write access to gists.

gist はもともとURLさえ知っていれば認証なしにだれでも見られるので、writeアクセスだけあれば大丈夫のようだ。


