---
title: "serverless-plugin-aws-alertsでエラーを監視"
date: 2020-07-05T20:48:54+09:00
draft: false
author: sakamossan
---

Serverless Framework を使っている場合、エラーやタイムアウトなどの検知をするためのリソースはプラグインで簡単に簡単に生成できる

- [ACloudGuru/serverless-plugin-aws-alerts: A Serverless Framework plugin that creates CloudWatch alarms for functions.](https://github.com/ACloudGuru/serverless-plugin-aws-alerts)

たとえば「エラー発生時には通知をうける」といった機能には以下のリソースを作る必要があるが、このプラグインはそれを(けっこう親切に)面倒みてくれる

- CloudWatch Alarm
- SNS Topic


#### CloudWatch Alarm

- CloudWatchでLambdaのエラーの発生数がわかっている
- CloudWatch Alarm はその発生数が域値以上かどうかを監視してくれるリソース
- エラーの発生数が指定以上となった場合にSNSへメッセージを送れる

#### SNS Topic

- エラーが発生したときにメッセージがキューに入る
- キューがどんな処理をキックするかはその先の設定次第
  - だいたいAWSChatBotにSlack通知させることになる


## 設定例

もともと serverless-plugin-aws-alerts はデフォルトの設定がしっかりしていて、なんも設定を書かなくてもエラーの監視はしてくれるようになっている

- [serverless-plugin-aws-alerts#default-definitions](https://github.com/ACloudGuru/serverless-plugin-aws-alerts#default-definitions)

ただ、デフォルトだと Duration や Invocation, Throttle など色々な状態を監視するAlarmができてしまうので、エラーだけ監視したいという場合は以下のような塩梅になる

```yaml
custom:
  # serverless-plugin-aws-alerts用の項目
  alerts:
    # どのstageでアラート用のリソースを作成するか ["prod", "dev"] とかでもよい
    stages: [ "prod" ]
    # ここに記述した数だけSNSTopicが生成される
    topics:
      # 異常が発生した場合にメッセージが送られるトピック
      alarm:
        topic: ${self:service}-prod-alerts-alarm
      # 発生した異常が収束した場合にメッセージが送られるトピック
      ok:
        topic: ${self:service}-prod-alerts-ok
    alarms:
      # ここに書くのは監視する項目のリスト。他にもタイムアウトなどを監視できる
      # 60秒間でエラーが一回以上あれば〜 の60秒のような閾値のデフォルト値はこちら
      # https://github.com/ACloudGuru/serverless-plugin-aws-alerts#default-definitions
      - functionErrors
    # alarmに記述した監視項目のデフォルト設定を上書きするところ
    definitions:
      functionErrors:
        # cronが5分に1回実行される処理なら、チェック間隔も5分に1回でよい
        period: 300
        # 正常に戻った時にも通知が欲しい場合の設定
        topics:
          ok: ${self:service}-prod-alerts-ok
```

## 通知について

serverless-plugin-aws-alertsはSNSトピックをつくるところまでしかやってくれないので、そこから先にSlackへの通知は AWS ChatBot を使うと楽である (以前は通知するためのLambdaを実装する必要があった)

AWS ChatBot は2020年7月時点だとコンソールからGUIでしか設定できないので、ポチポチ設定すればよい。ただ、AWSChatBotを利用するためのRoleを作る必要はある (AWSChatBotのコンソール画面内でこの権限の生成が促されている)


## 参考

CloudWatch Alarm 周りの設定がよくわからなかったので以前に調べたメモ

- [cloudwatch、アラームの設定 (period, treatMissingData) | Tech Weblog | blog.n-t.jp](https://blog.n-t.jp/cloudwatch-alarm-treatMissingData/)
