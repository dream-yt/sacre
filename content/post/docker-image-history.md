---
title: "dockerイメージの、レイヤーとサイズの関係をみる"
date: 2019-07-05T12:52:40+09:00
draft: false
author: sakamossan
---

docker history を使うとみられる

## 例

```
$ docker history --no-trunc --format="{{.Size}}\t{{.CreatedBy}}" perl:5.20.0
0B	/bin/sh -c #(nop) CMD [perl5.20.0 -de0]
0B	/bin/sh -c #(nop) WORKDIR /root
6.55MB	/bin/sh -c curl -LO https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm         && chmod +x cpanm         && ./cpanm App::cpanminus         && rm ./cpanm
0B	/bin/sh -c #(nop) WORKDIR /usr/src
55MB	/bin/sh -c ./Configure -Duse64bitall -des         && make -j$(nproc)         && TEST_JOBS=$(nproc) make test_harness         && make install         && make veryclean
70.4MB	/bin/sh -c curl -SL http://www.cpan.org/src/5.0/perl-5.20.0.tar.gz                 | tar -xz --strip-components=1
0B	/bin/sh -c #(nop) WORKDIR /usr/src/perl
0B	/bin/sh -c mkdir /usr/src/perl
14.7MB	/bin/sh -c apt-get update && apt-get install -y curl procps
0B	/bin/sh -c #(nop) MAINTAINER Peter Martini <PeterCMartini@GMail.com>
116MB	/bin/sh -c apt-get update && apt-get install -y   bzr   cvs   git   mercurial   subversion  && rm -rf /var/lib/apt/lists/*
580MB	/bin/sh -c apt-get update && apt-get install -y   autoconf   build-essential   imagemagick   libbz2-dev   libcurl4-openssl-dev   libevent-dev   libffi-dev   libglib2.0-dev   libjpeg-dev   libmagickcore-dev   libmagickwand-dev   libmysqlclient-dev   libncurses-dev   libpq-dev   libpq-dev   libreadline-dev   libsqlite3-dev   libssl-dev   libxml2-dev   libxslt-dev   libyaml-dev   zlib1g-dev  && rm -rf /var/lib/apt/lists/*
0B	/bin/sh -c #(nop) CMD [/bin/bash]
90.1MB	/bin/sh -c #(nop) ADD file:29e52cbeed164d50b33063694cdb46aa56f7410c17235c4ff8a30183741d21eb in /
0B
```


> --no-trunc

レイヤーのコマンドなどを(省略せずに)ぜんぶ表示する

> --format="{{.Size}}\t{{.CreatedBy}}"

出力項目のフォーマットを指定





