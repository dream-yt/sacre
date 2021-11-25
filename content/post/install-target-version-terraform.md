---
title: "[macOS] terraform をバージョン指定して brew でインストールする"
slug: install-target-version-terraform
date: 2021-11-25T17:51:43+09:00
draft: false
author: sakamossan
---

公式のドキュメントにしたがって `hashicorp/tap` を入れる。

```bash
$ brew tap hashicorp/tap
```

`hashicorp/tap` に移動して git log で目当てのバージョンのコミットハッシュを探して checkout。

```bash
$ cd /usr/local/Homebrew/Library/Taps/hashicorp/homebrew-tap/Formula
$ git log terraform.rb
$ git checkout c44c38b4e2a71317d2bf41cc83aa92a1cf039b83
```

目当てのバージョンにできたのを確認してから brew install

```bash
$ brew install hashicorp/tap/terraform
```

## 参考

- [Install Terraform | Terraform - HashiCorp Learn](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started)
- [homebrewで過去のversionをインストールする](https://blog.n-t.jp/tech/install-old-package-with-brew/)

以前に自分でまったく同じ記事を書いていたのを忘れていた。

