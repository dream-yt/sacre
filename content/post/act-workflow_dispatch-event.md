---
title: "workflow_dispatch イベントを act でローカルで実行する場合"
date: 2020-12-27T23:29:37+09:00
draft: false
author: sakamossan
---

myjob という workflow_dispatch イベントで定義した job を act で実行したい場合。

`.act/stg.event.json` というファイルを作成する

```json
{
    "event": "workflow_dispatch",
    "inputs": {
        "stage": "stg"
    }
}
```

`--eventpath` で実行するイベントを指定

```bash
$ act --job myjob --eventpath .act/stg.event.json
```

## 参考

- [how to trigger a tag event locally · Issue #179 · nektos/act](https://github.com/nektos/act/issues/179)
