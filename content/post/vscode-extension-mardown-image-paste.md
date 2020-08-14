---
title: "vscodeにペーストすると画像をgithubにあげてくれるvscode-extension-mardown-image-pasteが便利"
date: 2020-01-15T14:48:04+09:00
draft: false
author: sakamossan
---

GitHubのコメント欄に画像を貼り付けられるのと同じ操作感でvscode上から画像をアップロードできる

とても便利

- [njleonzhang/vscode-extension-mardown-image-paste: read the image from system clipborad, optimize the size, upload to CDN, and return you the CDN link.](https://github.com/njleonzhang/vscode-extension-mardown-image-paste)


## セットアップ

- extension(vscode-extension-mardown-image-paste)をvscodeに入れる
- `$ npm install -g electron-image-ipc-server`
- `$ eiis`
  - このプロセスが動いてないとアップロードされない
- 設定
  - githubのアクセストークン
    - こちらから [Personal Access Tokens](https://github.com/settings/tokens)
  - TinyPNGのアクセストークン
    - [TinyPNG – Developer API](https://tinypng.com/developers)
  - 画像を配備するリポジトリをgithub上に作成
  - githubAssetFolder, proxy は設定しないでも動作した


## 使用

- マークダウン(.md)ファイル上で
- クリップボードに画像を入れておいて 
- コマンドパレットから `Paste Image` を実行
