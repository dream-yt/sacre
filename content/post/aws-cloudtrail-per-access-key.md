---
title: "AWSのアクセストークンが昨日どんなAPIコールを行なったか確認する"
date: 2019-06-10T13:31:32+09:00
draft: false
---

cloudtrailのlookup-eventsで昨日の分をすべてとる

```bash
$ aws cloudtrail lookup-events \
  --lookup-attributes AttributeKey=AccessKeyId,AttributeValue=xxxxxxxx \
  --start-time $(date -v -2d -u +"%Y-%m-%dT%H:%M:%SZ") \
  --end-time $(date -v -1d -u +"%Y-%m-%dT%H:%M:%SZ") \
  | tee /tmp/_
```

## 取得できるデータ

- EventSourceやEventNameなどでどのAPIが叩かれたかわかる
- EventTimeで時間もわかる

```
{
  "EventId": "7615c6ad-xxxx-4f42-baa4-d4f14d240d96",
  "EventName": "GetQueryExecution",
  "ReadOnly": "true",
  "AccessKeyId": "xxxxxx",
  "EventTime": 1560042666,
  "EventSource": "athena.amazonaws.com",
  "Username": "xxxx",
  "Resources": [],
  "CloudTrailEvent": {...}
}
```


## CloudTrailEvent

どんな感じでAPIを叩いたかも `CloudTrailEvent` で見られる

下記の例だとGetQueryExecutionの叩かれ方がrequestParametersなどをみればわかる

```json
$ cat /tmp/_ | jq -r .Events[0].CloudTrailEvent | jq .
{
  "eventVersion": "1.06",
  "userIdentity": {
    "type": "IAMUser",
    "principalId": "xxxx",
    "arn": "arn:aws:iam::xxxx:user/mossan",
    "accountId": "xxxx",
    "accessKeyId": "xxxx",
    "userName": "mossan"
  },
  "eventTime": "2019-06-09T01:11:06Z",
  "eventSource": "athena.amazonaws.com",
  "eventName": "GetQueryExecution",
  "awsRegion": "ap-northeast-1",
  "sourceIPAddress": "13.231.254.111",
  "userAgent": "aws-sdk-nodejs/2.320.0 linux/v8.10.0 exec-env/AWS_Lambda_nodejs8.10 callback",
  "requestParameters": {
    "queryExecutionId": "xxxx"
  },
  "responseElements": null,
  "readOnly": true,
  "eventType": "AwsApiCall",
  "managementEvent": true,
  "recipientAccountId": "xxxx"
}
```

## jqを使ってtsvに整形

大体の場合、どのAPIがどれくらいの頻度で叩かれてるかが見られればよいので、jqで以下のように整形すれば良い感じに見られる

`.EventTime|.+32400|todate` でUNIXエポックをJSTに変換している

```bash
$ cat /tmp/_ | jq -r '.Events[] | [(.EventTime|.+32400|todate),.EventSource,.EventName] | @tsv' | head
2019-06-09T10:11:06Z	athena.amazonaws.com	GetQueryExecution
2019-06-09T10:11:06Z	athena.amazonaws.com	GetQueryExecution
2019-06-09T10:11:05Z	athena.amazonaws.com	GetQueryExecution
2019-06-09T10:11:05Z	athena.amazonaws.com	GetQueryExecution
2019-06-09T10:11:05Z	athena.amazonaws.com	GetQueryExecution
2019-06-09T10:11:04Z	athena.amazonaws.com	GetQueryExecution
2019-06-09T10:11:04Z	athena.amazonaws.com	GetQueryExecution
2019-06-09T10:11:03Z	athena.amazonaws.com	GetQueryExecution
2019-06-09T10:11:02Z	athena.amazonaws.com	GetQueryExecution
2019-06-09T10:11:02Z	athena.amazonaws.com	GetQueryExecution
```
