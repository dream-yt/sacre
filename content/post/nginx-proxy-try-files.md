---
title: "nginx の try_files でよくやる設定の意味"
slug: nginx-proxy-try-files
date: 2022-03-03T18:23:26+09:00
draft: false
author: sakamossan
---

こんな設定をした場合の挙動について。

```
server {
  try_files $uri @proxy;
  location @proxy {
    proxy_pass http://app;
    ...
  }
}
```

- `$uri` はnginx側で設定される変数で、リクエストされたURLが入っている
- `try_files $uri @proxy` 
    1. `$uri` に静的ファイルが存在するなら、それを返す
    1. 存在しないなら、`location @proxy` 配下の設定にしたがって処理する

### @proxy

- なんらかの変数のように見える `@proxy` はファイルがなかった場合の internal redirect 先のことだった
- これは `location @proxy` という指定と組み合わせて使うと「該当の静的ファイルがなかったら `http://app` に proxy する」という設定になる


## 参考

- [Module ngx_http_core_module](http://nginx.org/en/docs/http/ngx_http_core_module.html#try_files)
- [Nginxのtry_filesディレクティブ設定例 - Qiita](https://qiita.com/kaikusakari/items/cc5955a57b74d5937fd8)
