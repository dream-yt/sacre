---
title: "perl の XS.c: loadable library and perl binaries are mismatched"
slug: perl-loadable-bin-lib-mismatched
date: 2021-02-18T14:29:16+09:00
draft: false
author: sakamossan
---

開発環境を docker-compose でやっていて、perlのバージョンをあげた時に発生。

> XS.c: loadable library and perl binaries are mismatched (got handshake key 0xc180000, needed 0xe180000)
> exited with code 1

書いてある通り、perlのバージョンと入れているライブラリのバージョンが合わないので発生している。

依存ライブラリは carton で管理しているが、carton は perl 自体のバージョンには感知しないので carton install しても carton は「すでにご指定のライブラリは入ってますよ」と言い、perl は「入ってるライブラリ(のビルド成果物)はうちのバージョンと違いますよ」となっている

docker-compose で volume を共有しているディレクトリを消して、再度入れ直したら動くようになる。

```bash
$ rm -rf ./docker/app/local/*
$ docker build . 
```

## 参考

- [XS.c: loadable library and perl binaries are mismatched (got handshake key 0xce00080, needed 0xdb80080) - Stack Overflow](https://stackoverflow.com/questions/61003436/xs-c-loadable-library-and-perl-binaries-are-mismatched-got-handshake-key-0xce0)
