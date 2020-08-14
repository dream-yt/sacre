---
title: "GCPのCloud Build入門"
date: 2019-07-17T15:47:50+09:00
draft: false
author: sakamossan
---

circleciではシェルのコマンドを組み合わせてビルドを実施するが、
GCPのcloudbuildはdockerイメージを使ってビルドを実施していく

- [クラウド ビルダー  |  Cloud Build  |  Google Cloud](https://cloud.google.com/cloud-build/docs/cloud-builders?hl=ja)

たとえば、ビルド処理でdockerイメージbuildする必要があるなら、クラウドビルダーのdockerイメージを使ってdockerイメージをpullするところから始まる (紛らわしい)


## リポジトリ

ソースコードをビルドするとして、そのソースコードをもってくるリポジトリが必要になる
デフォルトでCloud Buildは以下の3つのリポジトリに対応している

- CloudSourceRepository (GCP)
- BitBucket
- GitHub

GitHubなどの外部リポジトリとミラーリングできたり、フックして色々処理を動かせたりする

ビルドする場合はこんな処理順になる

1. GitHubへのpush
1. cloud build をトリガー、ビルドを実施


### checkout

Cloud Build では設定したリポジトリのコードがすべてカレントディレクトリにある状態で処理が開始される


## cloudbuild.yamlの例

cloudbuild.yamlは以下のような形式になる

```yaml
steps:
- name: 'gcr.io/cloud-builders/git'
  args: ['clone', 'https://github.com/GoogleCloudPlatform/cloud-builders']
  env: ['PROJECT_ROOT=hello']
- name: 'gcr.io/cloud-builders/docker'
  args: ['build', '-t', 'gcr.io/my-project-id/myimage', '.']
```

### name

`docker run` するイメージ名を指定する

デフォルトで使えるイメージはこちら

- [クラウド ビルダー  |  Cloud Build  |  Google Cloud](https://cloud.google.com/cloud-build/docs/cloud-builders?hl=ja)


### args

`docker run` に渡す引数はここに指定する


### その他

他にもステップを並列実行したり、環境変数を設定したりできる

- [基本的なビルド構成ファイルの作成  |  Cloud Build  |  Google Cloud](https://cloud.google.com/cloud-build/docs/configuring-builds/create-basic-configuration?hl=ja)
