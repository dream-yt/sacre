---
title: "AWS、LambdaまわりのIAM入門"
date: 2019-07-28T09:54:35+09:00
draft: false
author: sakamossan
---

lambda を使っていて、権限周りが分からなかったのでメモ


# 用語

- IAM
- IAMロール
- ポリシー
  - IAMポリシー
  - リソースポリシー


# IAM

権限周りを管理しているエンティティ

- どのAPI呼び出しを
- どのリソースに
- 許可/不許可するか

という定義がある


# IAMロール

IAMユーザに近い概念だが、同じ権限をサービス/idPなどにも移譲できる点で汎用的
たとえばこんなことができる

- Lambda や EC2インスタンス に紐づけて、そこからのAWSリソースAPI呼び出しを許可する
  - AWS サービスロール
- 他のAWSアカウントのIAMロールと紐づけて、アカウントをまたいで権限を渡す
  - クロスアカウントアクセスのロール
- シングルサインオンしたアカウントと紐づけて、AWSの操作権限を渡す
  - ID プロバイダアクセス用のロール


#### 参考

- [AWS再入門 AWS IAM (Identity and Access Management) 編 ｜ DevelopersIO](https://dev.classmethod.jp/cloud/aws/cm-advent-calendar-2015-getting-started-again-aws-iam/)

# ポリシー

IAMの定義。JSON形式になっている

- Action
  - 何を許可するか (eg: `ec2:StartInstances` )
- Resource
  - どのリソースに許可するか
    - たとえば特定のs3バケットのみに操作を絞りたいときはここを使う
    - eg: `*`
      - 全部許可。`ec2:StartInstances` ならどこででもできるようになる
    - eg: `arn:aws:dynamodb:us-east-2:0000000000:table/${aws:username}`
      - 自分のユーザ名と同じテーブルへの操作を許可する
- Effect
  - 許可( `Allow` )か不許可( `Deny` )かの二択


## IAMポリシー

Lambda はかならず実行ロールと呼ばれるIAMロールをつけて生成される
このIAMロールについているポリシーがIAMポリシー


## リソースポリシー

逆に Lambda をキックできる権限を渡すもの
たとえば SNS から Lambda を呼び出す時は SNS にリソースポリシーが必要

#### 例

`aws lambda add-permission` コマンドで作成できる

```bash
aws lambda add-permission --function-name MyFunc \
  --statement-id testtest \
  --action lambda:InvokeFunction \
  --principal sns.amazonaws.com \
  --source-arn arn:aws:sns:ap-northeast-1:000000:MySNS
```
