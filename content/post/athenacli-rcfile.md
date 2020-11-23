---
title: " .athenaclirc の使い方"
slug: athenacli-rcfile
date: 2019-10-03T07:38:18+09:00
draft: false
author: sakamossan
---

athenacli というCLIからathenaにクエリできるツールがある  
これのathenaclircファイルの記法がドキュメントになかったのでメモ


## 結論

こんな形式のファイルを用意して

```python
[aws_profile myprofile]

aws_access_key_id = 'AKIxxxxxxx'
aws_secret_access_key = 'SNMcxxxxxx-xxxx'
region = 'ap-northeast-1'
s3_staging_dir = 's3://aws-athena-query-results-ap-northeast-1/adhoc'
```

こんな感じでクエリを投げる

```bash
$ athenacli --profile myprofile --athenaclirc ./.athenaclirc -e 'show databases'
```


### 説明

`--profile` というオプションがあるが、
これは `~/.aws/credential` を見てくれるものではない

設定ファイル (toml?) 内でどの `aws_profile` の設定を見るかというもの
ちなみに引数に指定しないと `default` というプロファイルが使われる

その場合はこんな設定ファイルを書くことになる

```python
[aws_profile default]

aws_access_key_id = 'AKIxxxxxxx'
...
```


### .athenaclircの形式

.athenaclircファイルはconfigobjというモジュールでパースされている

- [Welcome to configobj’s documentation! — configobj 5.1.0 documentation](https://configobj.readthedocs.io/en/latest/index.html)

とくに何らか標準のファイルフォーマットではないようだ
(pythonっぽい独自のフォーマット)

