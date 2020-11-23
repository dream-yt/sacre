---
title: "IAM権限を絞ったuserでserverlessを使う"
slug: awscli-create-user-and-policy
date: 2019-11-02T15:10:56+09:00
draft: false
author: sakamossan
---

Serverless framework は `sls deploy` コマンドを叩くAWSユーザには admin アクセスを推奨している

>  Attach existing policies directly. Search for and select AdministratorAccess then click Next: Review. Check to make sure everything looks good and click Create user.

- [Serverless Framework - AWS Lambda Guide - Credentials](https://serverless.com/framework/docs/providers/aws/guide/credentials/)

しかし、SIなどの堅めの組織や大企業病がひどいところだと開発者に与えられる権限は制限されることもある。そうなると制限された権限を使っている姿勢をとることが必要になってくる

本家のリポジトリでも、どれくらい権限をせばめても開発が行えるか議論がされている

- [Narrowing the Serverless IAM Deployment Policy · Issue #1439 · serverless/serverless](https://github.com/serverless/serverless/issues/1439)


## 前提

どんな用途でつかわれるpolicyなのかでけっこう違う権限が必要

色々考えられる

- sls deploy でリソースがCloudFormationStackの作成から行える権限
- 既存のlambda関数のソースコードが更新できればよい権限
- sls で管理するリソースにkmsやroute53などが含まれているかどうか

今回は `sls deploy でリソースがCloudFormationStackの作成から行える権限`  という前提で権限を整理していた。ほぼほぼ色々なことができてしまうが、ミス等で致命的なリソースを削除してしまうリスクを担保したものを考えた


## policy.yaml

- こんなpolicyを書いたら sls deploy は通った
- その他権限を渡したくないものがあったらDenyで弾いてもらう

```yaml
Version: '2012-10-17'
Statement:
- Sid: AllowLambdaAPIGateway
  Effect: Allow
  Action:
  - apigateway:*
  - lambda:*
  - logs:*
  - events:*
  - s3:*
  Resource: '*'
- Sid: AllowIAM
  Effect: Allow
  Action:
  - iam:GetRole
  - iam:PassRole
  - iam:CreateRole
  - iam:DeleteRole
  - iam:CreateServiceLinkedRole
  - iam:DetachRolePolicy
  - iam:PutRolePolicy
  - iam:AttachRolePolicy
  - iam:DeleteRolePolicy
  Resource: '*'
- Sid: AllowCloudFormation
  Effect: Allow
  Action:
  - cloudformation:CreateStack
  - cloudformation:Describe*
  - cloudformation:ValidateTemplate
  - cloudformation:UpdateStack
  - cloudformation:List*
  # cloudformation:DeleteStack は省いている。UIから消せればよい
  Resource: '*'
# 悪用やミスで触ってしまうとマズいリソースにはdeniedを設定する
- Sid: DenyS3
  Effect: Deny
  Action: s3:*
  Resource:
  - arn:aws:s3:::apiaccess-1wqlmdji14kx3
- Sid: DenyIAM
  Effect: Deny
  Action: iam:*
  Resource:
  - arn:aws:iam::1234567890:user/kms
```


### sls remove はできない

- `DeleteStack` 権限がないのでremoveはできない。期待通りの挙動
- `--aws-profile cr-slsdeploy` の部分は awscliのprofileを使うオプション

```console
$ serverless remove --verbose --aws-profile cr-slsdeploy --stage dev
Serverless: Getting all objects in S3 bucket...
Serverless: Removing objects in S3 bucket...
Serverless: Removing Stack...

  Serverless Error ---------------------------------------

  User: arn:aws:iam::836859347283:user/slsdeploy is not authorized to perform: cloudformation:DeleteStack on resource: arn:aws:cloudformation:us-east-1:1234567890:stack/testslsdeploypolicy-dev/0876f250-fd1e-11e9-94f2-0a583df6bf38
```
