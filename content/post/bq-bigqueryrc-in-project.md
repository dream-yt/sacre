---
title: "プロジェクトの.bigqueryrcの設定"
date: 2019-08-08T12:14:56+09:00
draft: false
author: sakamossan
---

- bqコマンド、`--maximum_bytes_billed` とか、デフォルトで設定しておきたいオプションはある
- .bigqueryrc というファイルを使うとbqコマンドのデフォルトオプションを設定できる

### どのパスの .bigqueryrc ファイルが使われるか

デフォルトだと `$HOME/.bigqueryrc` なので、そこは工夫が必要

> --bigqueryrc フラグが指定されていない場合は、BIGQUERYRC 環境変数が使用されます。これが指定されていない場合、パス ~/.bigqueryrc が使用されます。デフォルトのパスは $HOME/.bigqueryrc です。

- [bq コマンドライン ツールの使用  |  BigQuery  |  Google Cloud](https://cloud.google.com/bigquery/docs/bq-command-line-tool?hl=ja#setting_default_values_for_command-line_flags)


### プロジェクト .bigqueryrc ファイルを設定をする

direnvをつかって BIGQUERYRC 環境変数を設定する

```bash
export BIGQUERYRC=$(git rev-parse --show-toplevel)/.bigqueryrc
```

`git rev-parse --show-toplevel` で リポジトリのトップレベルのパスが取得できる


### .bigqueryrc ファイルの例

サブコマンドごとに `[サブコマンド名]` で区切って記述する

```
[query]
--max_rows=2147483647
--maximum_bytes_billed=200000000
--use_legacy_sql=false
```
