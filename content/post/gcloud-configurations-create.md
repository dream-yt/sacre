---
title: "gcloud コマンドで使う設定をプロジェクトごとに切り替える"
slug: gcloud-configurations-create
date: 2022-02-18T14:01:02+09:00
draft: false
author: sakamossan
---

- GCPの gcloud コマンドは、プロジェクトとアカウントを切り替えながら作業することができる
- `プロジェクトとアカウント` は configurations と呼び、ローカルに複数作ることができる


### configurations の一覧

```bash
$ gcloud config configurations list
```

デフォルトだと `default` という1つだけしかないはず


### configurations の作成

`xxxxxx` という名前の configurations を作成する

```bash
$ gcloud config configurations create xxxxxx
```


### configurations への設定

設定したい configurations が ACTIVE になっているのを確認してから、プロジェクトとアカウントを設定する。

```bash
$ gcloud config set account xxxxxxxxxx@gmail.com 
$ gcloud config set project this-power-123456
```


### configurations の切り替え

`$CLOUDSDK_ACTIVE_CONFIG_NAME` という環境変数で使う configuration を指定することができるので、direnv などでこの変数にプロジェクト用の名前をセットしておく。

```bash
export CLOUDSDK_ACTIVE_CONFIG_NAME=xxxxxx
```

