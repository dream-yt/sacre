---
title: "SSL越しにローカルの静的ファイルを閲覧したい (開発用)"
slug: devserver-ssl-static
date: 2019-07-10T18:26:22+09:00
draft: false
author: sakamossan
---

### SSLさせてくれるhttpサーバのコード

こちらから拝借

- [simple-https-server.py](https://gist.github.com/DannyHinshaw/a3ac5991d66a2fe6d97a569c6cdac534)

```python
import http.server
import ssl

server_address = ('127.0.0.1', 443)
httpd = http.server.HTTPServer(server_address, http.server.SimpleHTTPRequestHandler)
httpd.socket = ssl.wrap_socket(httpd.socket,
                               server_side=True,
                               certfile="server.pem",
                               keyfile="key.pem",
                               ssl_version=ssl.PROTOCOL_TLS)
httpd.serve_forever()
```

### 証明書を作ってserver start

```bash
$ mkdir /tmp/$(pwgen) && cd $_
$ pbpaste > test.html
$ openssl req -new -x509 -keyout key.pem -out server.pem -days 365 -nodes
# 質問には全部.(blank)で答えて良い
$ sudo python3 https.py
# SSL越しにみたいファイルを/tmp/$(pwgen)に入れる
```


### Chromeで見る

/etc/hosts をよしなに書き換えてから

```
127.0.0.1 example.com
```

警告を無視するオプションをつけて閲覧

```bash
$ /Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary \
  --ignore-certificate-errors \
  https://example.com/test.html
```


## 参考

- [simple-https-server.py](https://gist.github.com/DannyHinshaw/a3ac5991d66a2fe6d97a569c6cdac534)
- [Google Chrome: Bypass “Your connection is not private” Message](https://www.technipages.com/google-chrome-bypass-your-connection-is-not-private-message)
