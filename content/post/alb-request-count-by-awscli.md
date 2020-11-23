---
title: "ALBの直近1時間のリクエスト数をawscliで取得する"
slug: alb-request-count-by-awscli
date: 2019-01-20T15:05:24+09:00
draft: false
author: sakamossan
---

以下のコマンドで取得できる

```bash
aws cloudwatch --profile mossan get-metric-statistics \
    --namespace 'AWS/ApplicationELB' \
    --metric-name 'RequestCount' \
    --dimensions 'Name=LoadBalancer,Value=app/sakamoto-alb/xxxxxxxxx' \
    --statistics 'Sum' \
    --start-time $(date -v -1H -u +"%Y-%m-%dT%H:%M") \
    --end-time $(date -u +"%Y-%m-%dT%H:%M") \
    --period 3600
```


#### `--dimensions`

- RequestCountのSumをどの軸でGroupByするかを指定する
- 例だと1つのロードバランサーのアクセス数の合計
- ここに見たいALBのIDを入れる


#### `--start-time` / `--end-time` / `period`

- start/end-timeはUTCで指定する必要がある
- 直近1時間が欲しいので `period=3600`


### 参考

- [get-metric-statistics — AWS CLI 1.16.92 Command Reference](https://docs.aws.amazon.com/cli/latest/reference/cloudwatch/get-metric-statistics.html)
- [CloudWatchからメトリクスを取得する - NowTomの日記](http://d.hatena.ne.jp/NowTom/20131122/1385050337)

