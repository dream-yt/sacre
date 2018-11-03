---
title: "athenacliを使う"
date: 2018-11-03T18:11:44+09:00
draft: false
---

awscliにはathenaサブコマンドが用意されているが、gcpのbqコマンドのように便利な雰囲気ではない

- [athena — AWS CLI 1.16.47 Command Reference](https://docs.aws.amazon.com/cli/latest/reference/athena/)

シェルスクリプトにするのにもちょっと面倒な感じ

1. start-query-executionして、
1. get-query-executionしながらsleepしたりして
1. get-query-resultで結果を取得
1. 結果csvをs3から取ってくる

この面倒な部分をやってくれる便利なツールがあった

- [AthenaCLI — AthenaCLI documentation](https://athenacli.readthedocs.io/en/latest/)


## install

pipで入る

```console
$ pip install athenacli
Collecting athenacli
...
$ which athenacli
/usr/local/bin/athenacli
```

## 設定

athenaにクエリをかけるのには以下のような設定情報が必要となる

- aws-access-key-id
- aws-secret-access-key
- region
- s3-staging-dir (クエリの実行結果を置く場所)

これらをAthenaCLIに渡す方法はいろんな種類がサポートされている

- [AWS Configs — AthenaCLI documentation](https://athenacli.readthedocs.io/en/latest/awsconfig.html?highlight=athenaclirc#available-configs)

環境変数を使うならこんな感じになる

```bash
export AWS_ACCESS_KEY_ID=xxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxx/xxxxxxxxxx
export AWS_DEFAULT_REGION=ap-northeast-1
export AWS_ATHENA_S3_STAGING_DIR="s3://thisisyourbucket/athenacli/"
```

## 実行

ファイル名を渡しても、クエリを文字列で渡しても良い
結果は標準出力にcsvで出力される

```
$ athenacli -e src/queries/_.sql > /tmp/_.csv
```

