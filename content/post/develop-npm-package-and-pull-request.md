---
title: "誰かのnpmパッケージに機能追加して、本番で動作確認してからプルリクエストを出す"
slug: develop-npm-package-and-pull-request
date: 2020-05-04T23:19:32+09:00
draft: false
author: sakamossan
---

たとえばつぎのような場合

- プロジェクト `service` でつかっている `api-client` パッケージを使っている
- `api-client` に機能を追加したくなった


### api-client で機能追加

- まず `api-client` を GitHub で fork してローカルに clone
- masterブランチのまま欲しい機能を開発して(自分のmasterに)push
  - 開発中には npm link を使う


### 開発した機能を service でつかう

- `service` の package.json にはこういう風に書く
  - `"api-client": "git+https://github.com/myaccount/api-client.git",`
- `service` で npm install すると自分のforkしたコードが降りてくる
- `service` 側でテスト/動作確認などをする

OKならプルリクエストをだす

### プルリクエスト

- `api-client` で機能を追加する前のコミットからブランチ切る
- 実装した機能をcherry-pickしてプルリクエスト


## 参考

- [npmのモジュールを自分でforkした版のやつに差し替える - Qiita](https://qiita.com/DQNEO/items/28535b17ca263a0d2b71)

