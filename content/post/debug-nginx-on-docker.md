---
title: "docker を使って nginx の設定をいろいろ変更しながらデバッグする"
slug: debug-nginx-on-docker
date: 2022-03-03T17:21:48+09:00
draft: false
author: sakamossan
---

とりあえず openresty のイメージが docker run できることを確認する。

```console
$ docker run -p 8000:80 openresty/openresty:alpine
```

```console
$ curl -I localhost:8000
HTTP/1.1 200 OK
Server: openresty/1.19.9.1
Date: Wed, 02 Mar 2022 08:48:46 GMT
Content-Type: text/html
Content-Length: 1097
Last-Modified: Tue, 11 Jan 2022 12:43:05 GMT
Connection: keep-alive
ETag: "61dd7b59-449"
Accept-Ranges: bytes
```


## 設定ファイル

設定ファイルを追加したい場合についてはドキュメントに案内があった。

- [openresty/openresty - Docker Image | Docker Hub](https://hub.docker.com/r/openresty/openresty#nginx-config-files)

ただし、公式のとおりにやるにしても最小限の設定ファイルを用意する必要があるので、これまた公式の GitHub のデフォルト設定をもってくることにする。

- [docker-openresty/nginx.conf at master · openresty/docker-openresty](https://github.com/openresty/docker-openresty/blob/master/nginx.conf)

## volumeを作成

nginx と macOS でディレクトリを共有した状態で動かす。

```console
$ mkdir -p /tmp/mynginx/{conf.d,log,html}
$ curl 'https://raw.githubusercontent.com/openresty/docker-openresty/master/nginx.vh.default.conf' \
    -o /tmp/mynginx/conf.d/default.conf
$ echo "<html>this is test</html>" > /tmp/mynginx/html/test.html
```

http ディレクティブも変更して色々やりたい場合は `/usr/local/openresty/nginx/conf/nginx.conf` を書き換えるように。

```console
$ docker run --rm -p 8000:80 \
    -v /tmp/mynginx/conf.d:/usr/local/openresty/nginx/conf/ \
    -v /tmp/mynginx/log:/var/log/nginx \
    -v /tmp/mynginx/html:/usr/local/openresty/nginx/html \
    openresty/openresty:alpine
```

#### 確認

```console
$ curl localhost:8000/test.html
<html>this is test</html>
```

```console
$ cat /tmp/mynginx/log/host.access.log
172.17.0.1 - - [03/Mar/2022:03:18:57 +0000] "GET /test.html HTTP/1.1" 200 26 "-" "curl/7.64.1"
```

## 試行錯誤する

ここまでできたら、 nginx.conf か、default.conf を変更しながら設定の動作確認ができる。


## 参考

- [openresty/openresty - Docker Image | Docker Hub](https://hub.docker.com/r/openresty/openresty#nginx-config-files)
- [docker-compose でデバッグ用のボリュームマウントを行う](https://blog.n-t.jp/tech/docker-compose-volume/)
- [openresty/docker-openresty: Docker tooling for OpenResty](https://github.com/openresty/docker-openresty)
- [dockerで立ち上げたコンテナにログインする - Qiita](https://qiita.com/TakahiroSakoda/items/5180ff9762ebddb0bd4d)
- [dockerでコンテナが立ち上がらないときやってみること - Qiita](https://qiita.com/mom0tomo/items/35dfacb628df1bd3651e)
