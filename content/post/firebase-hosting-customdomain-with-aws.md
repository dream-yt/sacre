---
title: "AWSでドメインを取得してfirebase-hostingに設定する"
slug: firebase-hosting-customdomain-with-aws
date: 2020-09-03T09:45:26+09:00
draft: false
author: sakamossan
---

だいたいドキュメント通りにやればできる

- [カスタム ドメインを接続する  |  Firebase](https://firebase.google.com/docs/hosting/custom-domain?hl=ja)


## 手順

UIからポチポチやる場合の手順

- (AWS) まずドメインを取得
- (Firebase) カスタムドメインの追加をクリック
- (Firebase) 自分のサイトにつけたいドメインを入力
    - TXTレコードが払い出されるの
- (AWS) 所有権の確認
    - 払い出された文字列をTXTレコードとして設定
- (Firebase) 入力したTXTレコードを検証
    - 検証をパスすればドメインに対してIPアドレスが2つ払い出される
- (AWS) 払い出されたIPアドレスをAレコードに登録
    - httpsでアクセスできるようにするのはちょっと時間がかかった


#### 最終的にできるレコードはterraformだとこんな感じ

```
resource "aws_route53_record" "mydomain" {
    name    = "mydomain.com"
    records = [
        "google-site-verification=xxxxxxxxxx",
    ]
    ttl     = 300
    type    = "TXT"
    zone_id = "xxxxxx"
}
resource "aws_route53_record" "www--mydomain" {
    name    = "www.mydomain.com"
    records = [
        "151.123.12.345",
        "151.123.12.678",
    ]
    ttl     = 300
    type    = "A"
    zone_id = "xxxxxx"
}
```

AWSで作成したレコードの管理はこちらの記事でやった

- [terraformでroute53の管理](https://blog.n-t.jp/terraform-route53/)

