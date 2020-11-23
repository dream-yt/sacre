---
title: "WithingsAPIのトークンのを取得"
slug: withings-api-101
date: 2020-04-16T20:41:10+09:00
draft: false
author: sakamossan
---

## トークンの取得

- [Withings API](https://developer.withings.com/oauth2/#tag/glossary)

### codeを取得

管理画面から `CLIENT_ID` , `CONSUMER_SECRET` を発行する

- [dashboard_oauth2](https://account.withings.com/partner/dashboard_oauth2)

```bash
export CLIENT_ID=xxxx
export CONSUMER_SECRET=xxxxxxxx
export REDIRECT_URL=http://localhost:8000
export SCOPE=user.info,user.metrics,user.activity,user.sleepevents
export STATE=sakamoto  # リクエストが重複しないようにするためのなんでもいい文字列
```

ブラウザで開いて `アプリを許可する` 

```
open "https://account.withings.com/oauth2_user/authorize2?response_type=code&client_id=$CLIENT_ID&state=$STATE&scope=$SCOPE&redirect_uri=$REDIRECT_URL"
```

`REDIRECT_URL` で定義したURLへリダイレクトされる  
そのクエリパラメータに `code` が入っている

> http://localhost:8000/?code=xxxx&state=akira


### トークンの取得

POSTしたらJSONが返ってくる

```bash
export CODE=xxxxxxxxxxxx
curl https://account.withings.com/oauth2/token \
  -d 'grant_type=authorization_code' \
  -d "client_id=$CLIENT_ID" \
  -d "client_secret=$CONSUMER_SECRET" \
  -d "code=$CODE" \
  -d "redirect_uri=$REDIRECT_URL"
```

```json
{
  "access_token": "xxxxxxxxxx",
  "expires_in": 10800,
  "token_type": "Bearer",
  "scope": "user.info,user.metrics,user.activity,user.sleepevents",
  "refresh_token": "xxxxxxxxxxxxxxxxxxxx",
  "userid": "xxxxxxxxxx"
}
```

### トークンの更新

トークンは3時間で使えなくなる  
refresh_tokenを使って新しいのをゲットする

```bash
curl https://account.withings.com/oauth2/token \
  -d 'grant_type=refresh_token' \
  -d "client_id=$CLIENT_ID" \
  -d "client_secret=$CONSUMER_SECRET" \
  -d "refresh_token=$REFRESH_TOKEN"
```

こんなスクリプトを書いてなんとかした

```bash
#!/usr/bin/env bash
# usage: $ direnv exec bin/refresh-token.sh
set -eux
cd $(dirname $0)/../

export REFRESH_TOKEN=$(cat token | jq -r .refresh_token)
curl -s https://account.withings.com/oauth2/token \
  -d 'grant_type=refresh_token' \
  -d "client_id=$CLIENT_ID" \
  -d "client_secret=$CONSUMER_SECRET" \
  -d "refresh_token=$REFRESH_TOKEN" | jq . | tee ./token

```
