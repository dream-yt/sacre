---
title: "最近払い出した Slackの Incoming Webhooks で通知チャンネルを変更する"
slug: slack-webhook-deprecated
date: 2019-01-02T12:29:19+09:00
draft: false
author: sakamossan
---


### 残念

変更できないので調べたところ、
もうIncoming Webhooksでは通知チャンネルが変更できなくなっている


### Deprecated

ドキュメントを見に行ったらそういうことが書いてあった

> You're reading this because you're looking for info on legacy custom integrations - an outdated way for teams to integrate with Slack. These integrations lack newer features and they will be deprecated and possibly removed in the future. We do not recommend their use.

- https://api.slack.com/custom-integrations/incoming-webhooks#legacy-info

### どうすればいいの

`Slack apps` を使ってくださいということ

- [Building Slack apps | Slack](https://api.slack.com/slack-apps)

> Instead, we suggest that you read about their replacement - Slack apps. Slack apps can be built just for your own workspace or distributed through the App Directory, and they can use the latest and greatest APIs and UI features.

とは言ってもIncoming Webhooks対応してないライブラリあるしなぁ...

- [notifiers · PyPI](https://pypi.org/project/notifiers/)


### その他

もう使えないパラメータをわたしてたら、
レスポンスのボディになんらか警告を出して欲しいですよね

```
$ curl -X POST -H 'Content-type: application/json' --data '
    {"channel": "alert", "icon_emoji": ":t-rex:", "username": "mossan", "text": "test"}
' https://hooks.slack.com/services/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
ok
```
