---
title: "terraformでroute53の管理"
date: 2020-01-16T09:17:45+09:00
draft: false
---

## 前提

awsのコンソールから諸々設定をしたものを、terraformをつかってコード管理できるようにしていく場合の作業


## 前準備

まず最初に目当てのディレクトリでterraform initを叩く

```console
$ terraform init
```

適当なtfファイル(main.tfなど)を作成してproviderを記述

```
provider "aws" {
  region     = "ap-northeast-1"
  access_key = "xxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxx"
}
```

そのtfファイルに、空のリソースを定義しておく必要がある

```
# mydomain.comならこんな感じ
resource "aws_route53_zone" "mydomain" {}
```

## import

awsのコンソールなどからIDを持ってきて、それを引数にimportをたたく

```console
$ terraform import aws_route53_zone.mydomain Z1W0SAOSERTYU
```

recordをimportするときは若干特殊なID指定になる

> Route53 Records can be imported using ID of the record. The ID is made up as ZONEID_RECORDNAME_TYPE_SET-IDENTIFIER

こんな感じ

- `Z4KAPRWWNC7JR_dev.example.com_NS_dev`

[AWS: aws_route53_record - Terraform by HashiCorp](https://www.terraform.io/docs/providers/aws/r/route53_record.html#import)

```console
$ terraform import aws_route53_record.www--mydomain QT9WXXXXXXXX_www.mydomain.com_A
```

## plan

importしたあと、show/planを叩いて差分を確認、その通りにエディタで埋めていく


```console
$ terraform plan
```

## その他

間違えて自分で作成していないnsレコードをterraform-importした場合は `terraform state rm` で消し込む

```console
$ terraform state rm aws_route53_record.mydomain-ns
```

- [Command: state rm - Terraform by HashiCorp](https://www.terraform.io/docs/commands/state/rm.html)
