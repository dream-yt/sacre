---
title: "vercel をはじめてつかったときのメモ"
slug: vercel-101
date: 2020-11-21T11:56:23+09:00
draft: false
author: sakamossan
---

- [Introduction to Vercel - Vercel Documentation](https://vercel.com/docs)

だいたい思った通りのサービスだった

- GitHub のリポジトリがアプリと対応する
- master にマージすると自動的にデプロイが走る
  - master は常に動く状態になっていないといけない
- デフォルトだと npm run build が走るけど違うコマンドにもできる
- next アプリが rootDir にない場合はディレクトリが指定できる

GitHubAction と Firebase をいい感じに組み合わせたもの、という感じ。

### ビルド環境

vercel のビルドは amazonlinux2 イメージで行われる。

- [Build Step - Vercel Documentation](https://vercel.com/docs/build-step#build-image)

なのでビルドスクリプトで amazonlinux2 にないコマンドを発行するとエラーになる

## CLI

install は npm から

```bash
$ yarn global add vercel
```

### login

ログインが必要。メールアドレスを聞かれるが、これは GitHub のプライマリのメールアドレスを答える。

```bash
$ vercel login
```

### deploy

デプロイもできるが、デプロイしたい next アプリが rootDir にない場合は root まで登ってから実行する必要がある。

```bash
$ cd ../../
$ vercel deploy
```

### dev

rootDir にいかないといけないのは vercel dev (ローカル開発用のコマンド) も同様

```
$ cd ../../
$ vercel dev
```
