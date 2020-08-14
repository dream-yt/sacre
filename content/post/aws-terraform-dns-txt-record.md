---
title: "Terraform(AWS)でDNSのTXTレコードを作成する"
date: 2020-04-26T22:43:04+09:00
draft: false
author: sakamossan
---

Googleのサーチコンソールの認証をDNSでしたかったのでterraformで設定した

TXTレコードの値は `records` の中に入れる

```
resource "aws_route53_record" "b_n-t_jp__txt" {
  zone_id = "${aws_route53_zone.n_t.zone_id}"
  name = "b.f-f.jp"
  type = "TXT"
  ttl = "3600"
  records = ["google-site-verification=xxxxxxxxxx"]
}
```
