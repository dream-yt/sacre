---
title: "package.jsonの古いファイルをいっぺんに更新する"
date: 2019-07-15T18:50:46+09:00
draft: false
---


## 古いパッケージの一覧

```bash
$ npm outdated
```

こんな感じの出力が得られる

```
$ npm outdated
Package             Current  Wanted  Latest  Location
firebase-functions    2.3.1   2.3.1   3.1.0  project_name
firebase-tools       6.12.0  6.12.0   7.1.0  project_name
```


## いっぺんに更新する

以下のようなワンライナーで全部最新のに更新できる

```
$ npm outdated | grep -v ^Package | awk '{print $1}' | xargs -I{} yarn add {}@latest
```


## その他

`npm-check-updates` というコマンドをインストールすると
この辺りをよしなにやってくれるようだ (けどインストールするのも手間なのでワンライナーでなんとかしてしまった)


- [npm installしたパッケージの更新確認とアップデート(npm-check-updates) - dackdive's blog](https://dackdive.hateblo.jp/entry/2016/10/10/095800)

