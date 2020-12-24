---
title: "Chromeの検索バーで特定のサイト配下を検索する"
slug: chrome-search-bar-to-myblog
date: 2020-12-24T16:16:41+09:00
draft: false
author: sakamossan
---

Chromeの検索バーにはサイトを登録することができる。

検索窓に `duckduckgo.com` と入れてtabを押してから文言をいれて検索すると、Googleではなくduckduckgoの検索結果画面にいける。

![](https://raw.githubusercontent.com/sakamossan/image-bed/master/assets/79711023-07ba-590c-c303-319e551d1441.png)

duckduckgoのようなGoogle以外の検索はChromeの設定で追加することができる。
今回は自分のブログ `blog.n-t.jp` から検索できるように検索メニューを追加した。


## 設定画面の例

![](https://raw.githubusercontent.com/sakamossan/image-bed/master/assets/b268254c-3738-8666-5301-f4b256f518d4.png)

設定項目は

- 検索エンジンの名前
- キーワード (検索窓で呼び出すための名前)
- URL `%s` が検索文言に置換される。 `%s` のほかにも変数があるようだ (後述)

この機能をつかって、特定のサイト配下のGoogle検索結果にいくためのショートカットが設定できる。


## 設定例

> {google:baseURL}search?q=site:blog.n-t.jp %s

- `{google:baseURL}` が `https://google.com/` に置換される
- `site:blog.n-t.jp` で特定のドメイン配下の検索結果に絞ってくれる

この機能があるので自分のブログに検索窓をつけなくてもよい。
