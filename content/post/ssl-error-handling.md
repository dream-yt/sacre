---
title: "SSLエラー(dh key too small)が発生した時の調査/と対応"
slug: ssl-error-handling
date: 2019-10-02T14:04:08+09:00
draft: false
author: sakamossan
---

たとえばこんなエラーが出た時

> content:Cannot create SSL connection: SSL connect attempt failed error:141A318A:SSL routines:tls_process_ske_dhe:dh key too small

見たところ先方が使っている DH鍵 が短くてconnectionが取れないということのようだ

リクエスト先のホストをこのサイトでチェック

- [SSL Server Test (Powered by Qualys SSL Labs)](https://www.ssllabs.com/ssltest/analyze.html)

結果をこんな感じで返してくれる

- [SSL Server Test: publisher-api.spotxchange.com (Powered by Qualys SSL Labs)](https://www.ssllabs.com/ssltest/analyze.html?d=publisher%2dapi.spotxchange.com&s=198.54.12.118)

cipher suite の欄を見ると `DH 1024 bits` ということで鍵が短いようだ
(現行のOpenSSLではデフォルトで2048bitが使われる)

> TLS_DHE_RSA_WITH_AES_256_GCM_SHA384 (0x9f)   DH 1024 bits   FS   WEAK


### perl

DHを使わないようにするにはhttpsクライアントの設定おこなう

perlのFurlモジュールだとこんな感じ

> SSL_cipher_list => 'DEFAULT:!DH',
