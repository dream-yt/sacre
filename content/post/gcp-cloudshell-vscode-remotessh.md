---
title: "GCP Cloud Shell 上のコードを VS Code の Remote-SSH で触れるようにする"
slug: gcp-cloudshell-vscode-remotessh
date: 2021-12-24T17:07:37+09:00
draft: false
author: sakamossan
---

基本的にはこちらの記事のとおりにやればよかった。

- [Visual Studio CodeでGoogle Cloud Shellを開く - Qiita](https://qiita.com/mkizka/items/62ddf288b313323f390c)


## Cloud Shell を起動

- `cloud-shell` コマンドでログイン
- ここでssh鍵などがローカル側に生成される。生成された鍵は後で使う。

```bash
$ gcloud cloud-shell ssh
```

## コードのclone

プロジェクトのコードを Cloud Shell 上で触りたかったので、GitHub から `git clone` するためのトークンを払い出す。GitHub はURLにBasic認証みたいな細工をするとhttpsプロトコルでcloneができる。

```bash
$ git clone https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${REPOSITORY} .
# commitするのにこの辺の設定が必要。
$ git config --local user.name xxxxxxxxx
$ git config --local user.email xxxx@xxx.xx
```

このあたりをちゃんとやるのだと Secret Manger を使うのがよいようだ。

- [SSH 認証鍵を使用してビルドから GitHub にアクセスする  |  Cloud Build のドキュメント  |  Google Cloud](https://cloud.google.com/build/docs/access-github-from-build)


## .ssh/config

VS Code の Remote-SSH のために `$ ssh cloudshell_proj` でつながるような設定を仕込む。

```
Host cloudshell_proj
    ProxyCommand gcloud cloud-shell ssh --ssh-flag='-W localhost:22'
    User sakamossan
    IdentityFile ~/.ssh/google_compute_engine
    StrictHostKeyChecking no
```

## Remote-SSH の設定

これができたら VS Code のコマンドパレットから `Remote-SSH: Connect to Host...` を選択して、
接続先を入力する。 ↑のconfigだと `cloudshell_proj` と入れれば接続設定は完了。

ただし、自分の場合だと設定後すぐには接続に失敗してしまい、ここで1回 vscode を再起動しないとちゃんと接続できなかった。


## 参考

2022年は VS Code をちゃんと使うような年にしたい。

- [Visual Studio CodeでGoogle Cloud Shellを開く - Qiita](https://qiita.com/mkizka/items/62ddf288b313323f390c)
- [~/.ssh/configについて - Qiita](https://qiita.com/passol78/items/2ad123e39efeb1a5286b)
- [Scopes for OAuth Apps - GitHub Docs](https://docs.github.com/en/developers/apps/building-oauth-apps/scopes-for-oauth-apps)
- [githubからアクセストークンでcloneする - Qiita](https://qiita.com/reflet/items/b7ed9979828819b2b42c#%E5%8F%82%E8%80%83%E3%82%B5%E3%82%A4%E3%83%88)
- [VSCode の Remote - SSH 機能を使って EC2 上で開発する - サーバーワークスエンジニアブログ](https://blog.serverworks.co.jp/tech/2020/02/20/vscode-remote-ssh/)
- [Visual Studio Code でエディタとターミナルを移動するショートカットキーの作成 - Qiita](https://qiita.com/Shun141/items/fbed88abd4518f6d4039)
- [Visual Studio Codeで簡単にショートカットキーを変更する方法 - Qiita](https://qiita.com/kinchiki/items/dabb5c890d9c57907503)
