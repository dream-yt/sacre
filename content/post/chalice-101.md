---
title: "AWS Chalice でデプロイまで"
slug: chalice-101
date: 2020-11-07T00:20:37+09:00
draft: false
author: sakamossan
---

こちらに書いてある手順を踏んだだけ

- [Quickstart — AWS Chalice](https://aws.github.io/chalice/quickstart.html)

```console
$ python3 -m venv venv38
...
$ code .envrc
...
$ pip install --upgrade pip
$ pip install chalice
```

```console
$ chalice new-project sandbox
$ chalice deploy
Creating deployment package.
Creating IAM role: sandbox-dev
Creating lambda function: sandbox-dev
Creating Rest API
Resources deployed:
  - Lambda ARN: arn:aws:lambda:ap-northeast-1:xxxxxxxx:function:sandbox-dev
  - Rest API URL: https://xxxxxxxx.execute-api.ap-northeast-1.amazonaws.com/api/
```

## 生成されるファイル

```console
$ tree -a .
.
├── .chalice
│   ├── config.json
│   ├── deployed
│   │   └── dev.json
│   └── deployments
│       └── 041db0e7db2677b2098fef77581d1fcf-python3.8.zip
├── .gitignore
├── app.py
└── requirements.txt

3 directories, 6 files
```

```json
$ cat ./.chalice/config.json
{
  "version": "2.0",
  "app_name": "sandbox",
  "stages": {
    "dev": {
      "api_gateway_stage": "api"
    }
  }
}
```

```json
$ cat ./.chalice/deployed/dev.json
{
  "resources": [
    {
      "name": "default-role",
      "resource_type": "iam_role",
      "role_arn": "arn:aws:iam::xxxxxxxxxx:role/sandbox-dev",
      "role_name": "sandbox-dev"
    },
    {
      "name": "api_handler",
      "resource_type": "lambda_function",
      "lambda_arn": "arn:aws:lambda:ap-northeast-1:xxxxxxxxxx:function:sandbox-dev"
    },
    {
      "name": "rest_api",
      "resource_type": "rest_api",
      "rest_api_id": "xxxxcllgsl",
      "rest_api_url": "https://xxxxcllgsl.execute-api.ap-northeast-1.amazonaws.com/api/"
    }
  ],
  "schema_version": "2.0",
  "backend": "api"
}
```

## メモ

- ChaliceはデフォルトだとAWS-SDKでリソースを作るだけである
- CloudFormationするには chalice package などして色々する必要がある
    - [AWS CloudFormation Support — AWS Chalice](https://aws.github.io/chalice/topics/cfn.html?highlight=config%20json)
    - [Deploying AWS Chalice application using AWS Cloud Development Kit | AWS Developer Blog](https://aws.amazon.com/jp/blogs/developer/deploying-aws-chalice-application-using-aws-cloud-development-kit/)
- `deployed/dev.json` に書いてある以外にもリソースは生成されている
    - LambdaのCloudWatchLogsなどはつくられる
- ローカルでちょっと確認したいときは `$ chalice local` が使える