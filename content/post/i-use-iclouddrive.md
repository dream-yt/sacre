---
title: "iCloudドライブを使うようになった"
date: 2020-08-30T17:45:09+09:00
draft: false
author: sakamossan
---

最近iCloudドライブをちゃんと使っている。もともとは新しいMacをプロビジョニングするための設定ファイルを入れていたのみだが、以下のリンクを貼ってからけっこう色々なファイルを置くようになった。

```bash
ln -s "~/Library/Mobile Documents/com~apple~CloudDocs" ~/iCloudDrive
```

最近は子供ができたりコロナだったりで、仕事をするMacが4つある状態になっていた。

- 会社の MacBook Pro (2020)
- 家の Mac Mini (2018)
- 妻の実家に置かせてもらってる MacBook Pro (2015)
- 出先に持ってくノート MacBook Air (2013)

だいたいコードはGit管理なので問題なかったのだが、ちょっとしたメモや資料などはやっぱり勝手に共有されていて欲しい、

DropBoxに課金する一歩手前だったがiCloudの存在を思い出してよかった。iCloudでもけっこうなんとかなる。DropBoxと違って npm install でプロセスが暴走しないのもいい。


## こんなファイルを置いている

- ~/iCloudDrive/mac-provision-url.txt
  - 新しいMacをプロビジョニングするためのBrew Bundleや環境構築メモが入っている
  - MacだとiCloudには必ずログインするので、新しいPCでChromeより先にこのファイルが手に入るのは大きい
- ~/iCloudDrive/memo.md 
  - どんな作業をしてても開いているメモ。バッファ
- ~/iCloudDrive/pdf
  - Mac でダウンロードしてものをiPhoneで読んだりできたりして地味に便利だった
- ~/iCloudDrive/.bash_history-merged
  - bash_historyにちょっと手を入れて同期用にしたもの
  - Macの作業環境はディレクトリ構成/鍵も全部一緒なので基本historyが使いまわせるようになっている


## スクリプトも

最近は dotfiles や TIL, TODO管理などもiCloud配下に移行しようとしたのでこんなスクリプトを書いた。

#### move-and-symlink-under-iclouddrive.sh

```bash
#!/usr/bin/env bash
set -eux

readonly iclouddir="$HOME/iCloudDrive"
test -d $iclouddir

readonly src="$(dirname $1)/$(basename $1)"
readonly dest="$iclouddir/$(basename $1)"
test ! -d $dest

mv $src "$iclouddir/"
ln -s $dest $src
```

## 感想

とくに気にしないでファイルが同期されるのはやっぱり便利。Windows, Android 方面に進出するのが億劫になっちゃったけど、それは Raspberry-PI でSambaが構築できたらやってみようかなと思っている。
