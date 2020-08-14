---
title: "cloudwatch、アラームの設定 (period, treatMissingData)"
date: 2018-12-09T14:07:39+09:00
draft: false
author: sakamossan
---

`serverless-plugin-aws-alerts` を使うとアラームの設定/適用まで簡単に出来る

- [ACloudGuru/serverless-plugin-aws-alerts: A Serverless Framework plugin that creates CloudWatch alarms for functions.](https://github.com/ACloudGuru/serverless-plugin-aws-alerts)

以下の設定項目はパッと見で分からなかったのでメモ

- period
- treatMissingData


#### period

メトリクスの数値を監視するインターバル
単位は秒なので`600`とか設定すると10分に一回メトリクスの数値をチェックする挙動になる


#### treatMissingData

メトリクスの数値が取得できなかったなかった場合にどうするかの設定。
例えばperiodを600に設定した場合に、10分間lambdaが呼ばれなかったらDuration(実行時間)などのメトリクスは発生しないので数値が取得できない状態になる。

メトリクスの数値が取得できなかった場合は`INSUFFICIENT_DATA`としてアラーム状態になるのがデフォルトの設定。

treatMissingDataには以下の4つが設定できる

- breaching (欠落は問題アリとみなす)
- notBreaching (欠落を問題無しとみなす)
- ignore (欠落してるときは、その時のアラーム状態を維持する)
- missing (欠落してるときは、過去のデータを見に行く)

こちらの説明が詳しい

- [CloudWatch アラームの欠落データの処理の設定 - Amazon CloudWatch](https://docs.aws.amazon.com/ja_jp/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html#alarms-and-missing-data)

breaching, notBreachingの使い分けはわかるが、missingとignoreの使い分けが分かりにくい。アラームの通知を送るかどうかなどが関係あるのだろうか 🤔
