---
title: "Chalice の generate pipeline を試す (コードはGitHub)"
slug: chalice-generate-pipeline-use-github
date: 2020-12-06T22:07:00+09:00
draft: false
author: sakamossan
---

# chalice pipeline の動作検証

私用のAWSアカウントで chalice pipeline コマンドを試してみた。
デフォルトだとソースコードの管理は AWS Code Commit になるが、GitHubが使いたいのでそのようにした。


## AWS => GitHub へのアクセストークン

GitHubからソースコードを取得できるように、GitHubのアクセストークンを払い出す。権限はreposが読めればよい。

- [Personal Access Tokens](https://github.com/settings/tokens)

トークンをこんな感じのJSONに格納して、AWS Secrets Manager に置く。

```
$ cat /tmp/secrets.json
{"OAuthToken": "xxxxxxxx"}
```

```bash
$ aws secretsmanager create-secret --name GithubRepoAccess \
  --description "Token for Github Repo Access" \
  --secret-string file:///tmp/secrets.json
```

- [AWS Secrets Manager とは - AWS Secrets Manager](https://docs.aws.amazon.com/ja_jp/secretsmanager/latest/userguide/intro.html)

## 設定ファイルの生成

`chalice generate-pipeline` でパイプラインをつくるためのcloudformationテンプレートを生成する。

```bash
$ chalice generate-pipeline \
    --pipeline-version v2 \
    --source github \
    --buildspec-file buildspec.yml \
    pipeline.json
```

自分の場合はjsonだとコメントがつけられなくて不便だったのでyamlに変換した。

```
cat ./pipeline.json | yq -y . | tee ./pipeline.yaml
rm ./pipeline.json
```

- [mikefarah/yq: yq is a portable command-line YAML processor](https://github.com/mikefarah/yq)


## cloudformation deploy

cloudformationのテンプレートを適用する。

```
aws cloudformation deploy \
    --template-file pipeline.json \
    --capabilities CAPABILITY_IAM \
    --stack-name {{ }} \
    --parameter-overrides \
        GithubOwner={{ }} \
        GithubRepoName={{  }} \
```

`--capabilities` オプションは、AWSの仕様で承認していることを示すためにつける必要があるオプション。

> CloudFormation の仕様として、AWSアカウントのアクセス権限に影響するリソース（Roleの作成など）を含む可能性があるテンプレートを指定する場合、明示的に --capabilities を使ってテンプレート機能の承認を行う必要があります。

- [TECHSCORE｜知っておきたかったAWS SAM の小ネタ4選 | TECHSCORE BLOG](https://www.techscore.com/blog/2018/12/07/aws-sam-tips/)

### オプション

自動生成されるpipeline.yamlに用意されているオプションは以下の通り

```yaml
$ cat ./pipeline.yaml | yq -y .Parameters
ApplicationName:
  Default: sandbox
  Type: String
  Description: Enter the name of your application
CodeBuildImage:
  Default: aws/codebuild/amazonlinux2-x86_64-standard:3.0
  Type: String
  Description: Name of codebuild image to use.
GithubOwner:
  Type: String
  Description: The github owner or org name of the repository.
GithubRepoName:
  Type: String
  Description: The name of the github repository.
GithubRepoSecretId:
  Type: String
  Default: GithubRepoAccess
  Description: The name/ID of the SecretsManager secret that contains the personal
    access token for the github repo.
GithubRepoSecretJSONKey:
  Type: String
  Default: OAuthToken
  Description: The name of the JSON key in the SecretsManager secret that contains
    the personal access token for the github repo.
```

この2つは必須のオプション

##### GithubOwner

> The github owner or org name of the repository.

##### GithubRepoName

> The name of the github repository.

GitHubのURLはこうなってるので

> /repos/:owner/:repo/git/trees/:sha

たとえば[chalice](https://github.com/aws/chalice)の場合はこうなる

- `GithubOwner=aws`
- `GithubRepoName=chalice` 


## 実行

circleciのように buildspec.yml に定義したスクリプトが実行される。
