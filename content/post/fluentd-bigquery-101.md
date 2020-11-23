---
title: "Fluentd→Bigquery タグごとに別テーブルにinsert"
slug: fluentd-bigquery-101
date: 2019-12-28T11:12:24+09:00
draft: false
author: sakamossan
---

こんな設定でできる

```xml
<source>
  @type forward
</source>

<match bigquery.**>
  @type bigquery_insert

  <buffer tag>
    flush_interval 10
  </buffer>

  <inject>
    time_key time
    utc true
  </inject>

  auth_method json_key
  json_key /home/jibun/fluentd/xxxxxx-123456-35640a504591.json

  project myprj-135512
  dataset ${tag[1]}
  table ${tag[2]}
</match>
```


## プレースホルダー

この部分の設定で、タグごとに別テーブルへとinsertしている

```
  dataset ${tag[1]}
  table ${tag[2]}
```

fluentdは現在のバージョンでは `${tag[1]}` というようなプレースホルダーを設定に使うことができる

- [Config: Buffer Section - Fluentd](https://docs.fluentd.org/configuration/buffer-section#placeholders)

たとえば `bigquery.mydataset.temperature` タグを渡すと、
mydatasetというデータセットのtemperatureテーブルにデータを入れてくれる


## time_key

```xml
  <inject>
    time_key time
```

`time_key time` という設定をいれておくと、
時間を指定せずにメッセージを送ってもtimeカラムに送信日時が入ってくれる

##### 例

こんなコマンドを何回か叩いたとして

```bash
# timeカラムをメッセージに含めていない
echo "{\"value\": $RANDOM}" | fluent-cat bigquery.mydataset.temperature
```

これでちゃんと時間が入ってくれる

```sql
+---------------------+-------+
|        time         | value |
+---------------------+-------+
| 2019-12-28 02:11:26 | 25425 |
| 2019-12-28 02:11:28 | 13507 |
| 2019-12-28 02:11:33 | 31525 |
+---------------------+-------+
```


## buffer tag

この設定がないと

``` xml
 <buffer tag>
```

こんなエラーが出る

> Parameter 'bigquery_insert: project=xxxxxx-123456/dataset=${tag[1]}/table=${tag[2]}/fetch_schema_table=/template_suffix=' has tag placeholders, but chunk key 'tag' is not configured

ちゃんとプレースホルダーのドキュメントに書いてあった

> When the chunk keys are specified, these values can be extracted in configuration parameter values.

- [Config: Buffer Section - Fluentd](https://docs.fluentd.org/configuration/buffer-section#placeholders)

タグプレースホルダーを使うときはchunk-key(bufferの設定)のところでtagを指定しないとダメ


---

#### その他

`@type bigquery_load` を使う場合、 サービスアカウントに `bigquery.jobs.create` 権限が必要 (BigQuery編集者だとその権限はついていなかった) 

また、`bigquery_load` ではデータが少量すぎると以下のようなエラーが出ていた

> failed to poll load job error_class=Fluent::BigQuery::UnRetryableError error="notFound: Not found: Job penguin-171212:job_H555BgtYLRUQpxq-bnSBH3uAbBfn"

データはbigqueryに入っていたので、おそらく初回のポーリングまでに処理が終わってしまうような量だと発生するエラーかも
