---
title: "AWSでプロジェクトに存在するALBを一覧する"
date: 2019-01-20T14:57:42+09:00
draft: false
author: sakamossan
---

```bash
aws cloudwatch list-metrics \
    --namespace AWS/ApplicationELB \
    --metric-name RequestCount \
    | jq -r '.Metrics[].Dimensions[] | select(.Name | test("LoadBalancer")) | .Value' \
    | sort \
    | uniq
```

jq の部分はjsonから必要な部分を抜き出すためのもの

- 配列を `Name=LoadBalancer` なオブジェクトにフィルタして
- そのオブジェクトの `Value` 属性を取り出す

```json
[
    {
        "Name": "TargetGroup",
        "Value": "targetgroup/stg-api/xxxxxx"
    },
    {
        "Name": "LoadBalancer",
        "Value": "app/stg-private/ggggggg"
    },
    {
        "Name": "AvailabilityZone",
        "Value": "ap-northeast-1c"
    }
]
```
