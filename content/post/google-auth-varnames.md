---
title: "Google のAPIを叩く時の認証処理周りの変数名について"
slug: google-auth-varnames
date: 2021-03-05T12:49:18+09:00
draft: false
author: sakamossan
---

- [Node.js Quickstart  |  Google Calendar API  |  Google Developers](https://developers.google.com/google-apps/calendar/quickstart/nodejs)

サンプルコード内でそれっぽい変数名が出てくるけど、初見だと何を指しているのかわからなかったのでメモ

- client_secret.json
- token

#### client_secret.json

UI: `https://console.developers.google.com/apis/credentials`

- GoogleのUIからダウンロードするファイル
- json形式で秘密鍵とかが入っている

```json
{
  "installed": {
    "client_id": "0000000000-4m2rmmkhsd4n6pp4o5oj0957ot89f1m3.apps.googleusercontent.com",
    "project_id": "app-2343219",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://accounts.google.com/o/oauth2/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_secret": "SAHafsgwgmpfKoxxxxxxxxxxxx",
    "redirect_uris": [
      "urn:ietf:wg:oauth:2.0:oob",
      "http://localhost"
    ]
  }
}
```


#### token

oauthで取得する認証情報で、JWTのこと

```json
{
  "access_token": "ya29.GlvVBG-Gxf3XcW5cSoshNle1jm93dlxxxxxxxxxs3o-EEP",
  "refresh_token": "xxxxx3j2lTxxxxxxxxx_Ic",
  "token_type": "Bearer",
  "expiry_date": 1506123424861
}
```
