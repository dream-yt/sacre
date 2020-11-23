---
title: "GCP の cloudbuild を ローカルで実行する"
slug: gcp-cloud-build-local
date: 2020-05-07T08:29:36+09:00
draft: false
author: sakamossan
---

`cloud-build-local` というツールがあり、公式のドキュメント通りにやればだいたいできる

- [Building and debugging locally  |  Cloud Build Documentation](https://cloud.google.com/cloud-build/docs/build-debug-locally)


### 作業ディレクトリ

ビルドを実施するディレクトリは cloudbuild.yaml があるディレクトリではない。cloudbuild はリポジトリの最上位のディレクトリをCWDとして実行されるので、ローカルで実行する際もパスの指定はそこに合わせておくのがよい


### REVISION_ID

cloudbuild.yaml では `$REVISION_ID` という変数が使えるようになっているが、ローカルビルドだとこれは使えない

`--substitutions` で渡してやれば誤魔化すことができた

```
--substitutions REVISION_ID=buildlocal
```


### dryrun

デフォルトだと `dryrun=true` となっていて、cloudbuild.yaml ファイルの記述がルール通りかの構文チェックのみとなっている。実際にビルドやデプロイの処理をしたいときにはこれは `dryrun=false` とする


## コマンド

上記をふまえるとコマンドはこんな感じになった

```bash
$ cloud-build-local \
  --dryrun=false \
  --config=cloudbuild.yaml \
  --substitutions REVISION_ID=buildlocal \
  ../
```
