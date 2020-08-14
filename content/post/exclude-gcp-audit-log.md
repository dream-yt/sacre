---
title: "CloudLogging で監査ログを除外する"
date: 2020-06-05T07:08:03+09:00
draft: false
author: sakamossan
---

GCPには、ユーザの操作などを記録する監査ログがデフォルトで有効になっているサービスがいくつかある

- [監査ログについて  |  Cloud Logging  |  Google Cloud](https://cloud.google.com/logging/docs/audit/understanding-audit-logs)

BigQuery の監査ログが邪魔で除外したかった(コンソールの操作でテーブル名を間違えたときとかにもエラーログが出ていた)ので、CloudLogging のクエリでこの監査ログをexcludeした

こんな条件を入れればよい

```
NOT protoPayload.@type="type.googleapis.com/google.cloud.audit.AuditLog"
```

ドキュメントにはこう書いてある

> これは監査ログエントリなのか？ 次の 2 つのことから、監査ログエントリであることがわかります。
> protoPayload.@type フィールドは type.googleapis.com/google.cloud.audit.AuditLog です。
> logName フィールドにはドメイン cloudaudit.googleapis.com が含まれています。

## 参考

- [高度なログクエリ  |  Cloud Logging  |  Google Cloud](https://cloud.google.com/logging/docs/view/advanced-queries?hl=ja)
