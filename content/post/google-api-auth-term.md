---
title: "Google Api Auth Term"
slug: google-api-auth-term
date: 2021-03-04T18:06:16+09:00
draft: false
author: sakamossan
---

サンプルコード内でそれっぽい変数名が出てくる

- [Node.js Quickstart  |  Google Calendar API  |  Google Developers](https://developers.google.com/google-apps/calendar/quickstart/nodejs)

- token
- client_secret.json

#### client_secret.json

UI: `https://console.developers.google.com/apis/credentials`

- GoogleのUIをポチポチやってファイルダウンロードするもの
- json形式

```json
{
  "installed": {
    "client_id": "0000000000-4m2rmmkhsd4n6pp4o5oj0957ot89f1m3.apps.googleusercontent.com",
    "project_id": "penguin-2343219",
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

- oauthで取得する認証情報
- これもjson形式
- 時限でexpireしないtokenとしてこれをサーバに置いて認証してもらう

```json
{
  "access_token": "ya29.GlvVBG-Gxf3XcW5cSoshNle1jm93dlx3LRwJkFrIayQkdiTPyQGyviRVR5ds95lvBA_ejZyIJUYrx3f1Q8QbU6fKYtdwpMxqntQvuWn51RtdAPW3S4BJrs3o-EEP",
  "refresh_token": "1/-V3j2lT1cnYBehEdetqu8y3zPzNTL7KZKicr35-q_Ic",
  "token_type": "Bearer",
  "expiry_date": 1506678724861
}
```
