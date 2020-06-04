---
title: "LogEntry からそのログ周辺へのCloudLogging のURLを生成する"
date: 2020-06-04T16:21:16+09:00
draft: false
---

こんな処理をつくるとき

- CloudLogging でエラーログを補足したら
- そのログを PubSub にシンクして
- それを CloudFunction でSlackに通知する
 
通知メッセージの中にそのログへのリンクを置きたくて、URLを生成する処理を書いた


## LogEntry

CloudFunction は LogEntry という構造体を呼び出し時に受け取る

- [LogEntry  |  Cloud Logging  |  Google Cloud](https://cloud.google.com/logging/docs/reference/v2/rest/v2/LogEntry)

この中の `timestamp` と `resource.type` を使う


## ログクエリ

CloudLogging は、URLにログクエリを埋め込むことができる

- [高度なログクエリ  |  Cloud Logging  |  Google Cloud](https://cloud.google.com/logging/docs/view/advanced-queries?hl=ja)

以下のような条件のログクエリを生成して、それをURLにつける

- 同じ `resource.type`
- エラーログの発生から前後10秒

`insertId` でもそのログへのリンクが生成できるが、たぶんエラーログの場合は前後に何があったか知りたいはずなので「エラーログの発生から前後10秒」にしている


## コード

こんな感じ

```ts
import { URL } from 'url';
import * as querystring from 'querystring';

const buildLogEntryUrl = (log: LogEntry, projectId?: string) => {
  const at = new Date(log.timestamp);
  const from = new Date(at.getTime() - 10000).toISOString();
  const to = new Date(at.getTime() + 10000).toISOString();
  const query = querystring.escape(
    [
      `timestamp>="${from}"`,
      `timestamp<="${to}"`,
      `resource.type=${log.resource.type}`,
    ].join('\n')
  );
  const param = projectId ? `?project=${projectId}` : '';
  return new URL(
    `https://console.cloud.google.com/logs/query;query=${query}${param}`
  );
};
```

`project` はクエリパラメータにつけると一意になるので、つけれそうならつける
