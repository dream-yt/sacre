---
title: "StackDriverLoggingのログへのクエリ入門"
slug: stack-driver-log-query-101
date: 2019-11-26T18:46:57+09:00
draft: false
author: sakamossan
---

- クエリ内の文字列にはダブルクオートを使う必要がある (シングルクオートはダメそう)
- ログがjson形式の場合は `jsonPayload.requestUrl` とかでペイロードを使ったクエリもかける

こんなクエリを書くことになる

```bash
gcloud logging read '
  logName="projects/my-proj/logs/openresty"
  jsonPayload.requestUrl="http://example.com/api/"
  timestamp>="2019-11-21T20:05:00+09:00"
  timestamp<="2019-11-21T20:06:00+09:00"
  ' --format=json --limit=10 --order=asc
``` 

クエリを別ファイルに書きたいならこんな感じ

```bash
gcloud logging read "$(cat ,/stackdriver/test.logquery)" \
  --format=json --order=asc
```

### その他メモ

- なぜか `--order` のデフォルトがdescなので見慣れた形式にするならasc (普通は最新のログが下にくるよね)
- プロジェクト内のlogNameのリストを見るのは `$ gcloud logging logs list`
- 直近の5分の結果が欲しいなら `--freshness=5M` というオプションがつけられる
- 容赦無く条件に合うもの全件取得してきちゃうようなので結果が大きそうなら `--limit=10` とか必要
