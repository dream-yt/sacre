---
title: "SlackAPI よりチャンネルとアイコンとユーザ名を変更してポストする"
slug: slack-get-postmessage-token
date: 2020-06-05T01:04:32+09:00
draft: false
author: sakamossan
---

現在、Slack は昔ながらの Webhook の方式ではチャンネルとアイコンとユーザ名をすべてデフォルトから変更してポストできなくなっている

- [Sending messages using Incoming Webhooks | Slack](https://api.slack.com/messaging/webhooks)

> You cannot override the default channel (chosen by the user who installed your app)

各々カスタマイズしてポストするには OAuth トークンを使う方式になる

### トークンの取得

トークンの取得の仕方も昔と変わっている。管理画面のどこからトークンが取得できるかは↓の記事がわかりやすかった

- [Slack API 推奨Tokenについて - Qiita](https://qiita.com/ykhirao/items/3b19ee6a1458cfb4ba21)


### 必要なスコープ

掲題の件ではこの3つの権限を持ったトークンの払い出しが必要だった

- chat:write
- chat:write.customize
- chat:write.public
