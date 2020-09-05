---
title: "httpリクエスト(v1.0で)のProxy"
date: 2020-08-30T18:59:16+09:00
draft: false
author: sakamossan
---

読書メモ

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=rocklaakira-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=4873119030&linkId=9e354f8f400ef74197244e6fe1357156"></iframe>

いままで「プロキシ」というのがhttp標準の技術だってことを知らなかった。httpsの場合だとCONNECTメソッドが出てきたりするがいったんhttp/1.0の場合でメモ


## curl

curlだとこんなコマンドでプロキシの情報を含んだリクエストを投げることができる

```bash
curl --http1.0 -x http://localhost:18888 http://example.com/helloworld
```

## サーバー側が受け取るリクエスト

サーバ側(localhost:18888)ではこんなリクエストを受け取る

```
GET http://example.com/helloworld HTTP/1.0
Connection: close
Accept: */*
Proxy-Connection: Keep-Alive
User-Agent: curl/7.64.1
```

プロキシ情報を含んだリクエストはGET以降のパス部分が、URL全体を指定したものになっている。

- `/helloworld` ではなく
- `http://example.com/helloworld` になる


## 実装次第

リクエストを受け取ったプロキシサーバは指定されたURLへリクエストを中継して結果をクライアントに返すことが期待される。が、このあたりはプロキシサーバの実装次第なので自分で python http.server とかで立てたサーバにこのようなリクエストを送っても、もちろんプロキシはしてくれない。
