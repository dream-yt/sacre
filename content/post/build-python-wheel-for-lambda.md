---
title: "cエクステンションを使っているpythonパッケージをlambdaで動くようビルドする"
slug: build-python-wheel-for-lambda
date: 2020-11-20T06:44:01+09:00
draft: false
author: sakamossan
---

cエクステンションを使っているpythonパッケージをビルドするとビルドしたプラットフォーム固有のwheelファイルが生成される。
つまりLambda(Linux)上で動かしたいバイナリをビルドするときにmacOS上でやってしまうとうまくいかないということである。

macを使いながらLambda向けのwheelを得るには、Lambda環境に似せたDockerイメージを使ってそのなかでビルドする。

- [lambci/docker-lambda: Docker images and test runners that replicate the live AWS Lambda environment](https://github.com/lambci/docker-lambda)

このコマンドでLambda向けのwheelファイルを作ることができる。

```bash
$ docker run --rm --volume $(pwd):/var/task \
    lambci/lambda:build-python3.8 \
    pip wheel {{ modulename }} -w /var/task
```

`--volume $(pwd):/var/task` でコンテナ内:/var/taskに生成したファイルがホスト側の今いるディレクトリに置かれるのがミソ。
