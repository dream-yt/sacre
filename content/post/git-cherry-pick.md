---
title: "commitを別の作業branchへ移動する方法"
date: 2018-11-28T22:27:25+09:00
draft: false
author: dream-yt
categories: [ "git" ]
tags: [ "git" ]
---

![This is a image](/images/post/dream/GitCherryPick01.png)

# これは一体
Gitで何度も陥ってしまう過ちにまたハマってしまう日が来ても、乗り越えられる自分でありたい。
そのための備忘録です。

# 状況
新しい作業の開始時に、branchの切り替えを忘れてしまう。</br>
前回まで作業してたbranchやmasterで作業を開始してしまった時に、正しいbranchに作業したcommitを移動する。

......これ、自分的にはあるあるすぎる。何回やってんだ。

# やること

**[start地点]** </br>
正しくないbranch Aで作業を開始してしまった。移したいcommitは3つ。

**1. 移動先branchがない場合は作成** (branch B)

**2. branch Aで下記コマンドを叩いて、移動するcommitのIDを確認**

- 末尾に `-10`などいれると最新のcommitを上から10個表示するなど指定できる

```bash
$ git log --oneline 
```
![This is a image](/images/post/dream/GitCherryPick02.png)

**3. branch Bに移動して移したいcommitをcherry pick する**

- コマンドの後にcommit IDを入力
- 古い順に入力すること

```bash
$ git cherry-pick xxxxxxx yyyyyyy zzzzzzz
```

**4. commitがbranch Bに移動できているかlogで確認**
```bash
$ git log --oneline 
```

**5. 必要があればbranchAのcommitを消去**

- 下記のコマンドでできるらしい
- HEAD~xは任意の数値に変更

```bash
$ git reset --hard HEAD~3
```

# 他のやりかた
branch Bがまっさら状態だった場合、

**1. branch Aで作業をstashにしまう**
```bash
git stash
```

**2. branch Bでstashを開ける**
```bash
git stash pop
```
というやり方もあるらしい。</br>
この場合、branch AとBの作業箇所が被らないことが前提となる。（コンフリクトするため）

備忘のために書いたとはいえ、同じことを繰り返さない自分であってほしい。
