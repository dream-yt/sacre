---
title: "docker-compose でデバッグ用のボリュームマウントを行う"
slug: docker-compose-volume
date: 2021-06-01T12:05:18+09:00
draft: false
author: sakamossan
---

プロジェクトのローカル開発に docker-compose を使っているとして、個人的なデバッグや動作検証で使うためのディスク領域を作りたい時のメモ。

Docker では `--mount` オプションでホストOSとDocker上のファイルシステムで共用できるディスクを作れるが、`docker-compose exec` コマンドにはそのようなオプションがない。(いちおう `docker run` には `--volume` オプションが存在するようだ)

### docker-compose.override.yml

オプションで指定できないので `docker-compose.yml` で指定することになるが、複数人で開発しているプロジェクトなので個人的なデバッグ用のコードをさし挟むことはできない。 `docker-compose.override.yml` を使うことになる。

```yaml
version: '3'
services:
  rfp:
    volumes:
      - type: bind
        source: /var/tmp/audio
        target: /hostos/audio
```

`volumes` オプションは配列であるが、overrideファイルで定義すると append したような挙動になってくれる。

## その他

`docker-compose` コマンドは未知のオプションをつけると、エラーを出力せず、またリターンコードも0でプロセスが終了する。
`docker-compose exec` に `--mount` オプションをつけて実行していたときは「よくわからないがコマンドが実行されない」という状態になり少し戸惑った。

```console
$ docker-compose exec \
>     --mount \
>         type=bind \
>         src=/var/tmp/audio \
>         dst=/hostos/audio \
>     app carton exec perl tools/,/_.pl
$ echo $?
0
```

## 参考

- [Docker の Volume がよくわからないから調べた - Qiita](https://qiita.com/aki_55p/items/63c47214cab7bcb027e0)
