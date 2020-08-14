---
title: "LambdaのエラーをコーディングなしでSlack通知までしてもらう設定"
date: 2018-11-23T14:04:09+09:00
draft: false
author: sakamossan
---

serverlessを使っている前提

- slackの `bring emails into slack` を使う
    - slack通知用のメールアドレスを取得
    - このアドレスにメールを送ると、内容がslack(自分とslackbotのDirectMessage)に投稿される
- slsプラグイン `serverless-plugin-aws-alerts` を使う
    - AWS::CloudWatch::Alarm でエラーを検知
    - AWS::SNS::Topic でエラー内容をメール送信
    - 送信先にslackから払い出されたメールアドレスを入れる


##### メモ

- SNSにメアドを設定した時、確認メールがくるのでメール内のconfirmリンクを踏んでおく
- SNSからのメールの履歴を残したい場合は{ Gmail => slackメール }で転送する
    - Gmailの転送設定が必要


### 参考

- [Slack でメールを受信する – Slack](https://get.slack.help/hc/ja/articles/206819278-Slack-%E3%81%A7%E3%83%A1%E3%83%BC%E3%83%AB%E3%82%92%E5%8F%97%E4%BF%A1%E3%81%99%E3%82%8B)
- [serverless-plugin-aws-alerts: A plugin that creates CloudWatch alarms for functions.](https://github.com/ACloudGuru/serverless-plugin-aws-alerts)

