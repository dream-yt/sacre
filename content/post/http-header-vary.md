---
title: "HTTPのVaryヘッダについて"
slug: http-header-vary
date: 2021-03-12T18:17:07+09:00
draft: false
author: sakamossan
---

- Varyは中間のキャッシュサーバで活用することが期待されてるヘッダ
- nginx や h20 などのオリジンサーバがレスポンスヘッダに入れてキャッシュサーバを制御するために使う
- キャッシュサーバは Vary の指定を参照して、キャッシュをいくつかに分けて保持する
    - `Vary: HOGEHOGE` と指定した場合はHOGEHOGEヘッダの値を参照してキャッシュを複数もつことになる

### 例

`Vary: Accept-Encoding` とすると、キャッシュサーバは同じURLでも次の2種類のキャッシュを保持してくれる

- `Accept-Encoding: gzip` 
- `Accept-Encoding: plain` 

たとえば、古いガラケーでは gzip が inflate できなかったので、gzip 圧縮されたキャッシュをクライアントに返してしまうと表示ができない。 `Vary: Accept-Encoding` と指定して、ガラケーの場合はガラケー用のキャッシュを保持/返答するようにしないといけない。


## 参考

- [コンテンツキャッシュとVaryヘッダとnginx - Qiita](http://qiita.com/cubicdaiya/items/09c8f23891bfc07b14d3)
