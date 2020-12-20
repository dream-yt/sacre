---
title: "[terraform] Error: Invalid legacy provider address"
slug: terraform-error-invalid-legacy-provider-address
date: 2020-12-20T09:37:05+09:00
draft: false
author: sakamossan
---

ひさしぶりに terraform をアップグレードしたら以下のようなエラーが出るようになった。

> Error: Invalid legacy provider address
> This configuration or its associated state refers to the unqualified provider "aws".
> You must complete the Terraform 0.13 upgrade process before upgrading to later versions.

これは tfstate の形式が古くなっていて、v0.14 で読めなくなってしまったということらしい。
案内の通りに terraform を一度 v0.13 に戻す。

brew で入れていたので指定したバージョンにするのは少し面倒だった

```bash
$ brew info terraform
$ cd /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula
$ git log terraform.rb
$ git checkout c67b17cb80b042825f00f1768c422a1df637ad4b terraform.rb
$ brew unlink terraform
$ brew install terraform
```

v0.13だと問題なく通った

```
$ terraform init
$ terraform plan -out=tf-plan.out
$ terraform apply tf-plan.out
```

v0.13 で terraform apply すると、tfstate が新しい形式で更新されて v0.14 にあげてもこのエラーは出なくなるそうだ。


## 参考

- [Unqualified provider "aws" - Terraform - HashiCorp Discuss](https://discuss.hashicorp.com/t/unqualified-provider-aws/18554)
- [Homebrewで過去バージョンのパッケージをインストールする方法 - SIS Lab](https://www.meganii.com/blog/2019/12/03/how-to-install-an-older-version-of-a-homebrew-package/)
