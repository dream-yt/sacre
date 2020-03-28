---
title: "s3オブジェクトのタグに使える文字"
date: 2020-03-28T15:46:19+09:00
draft: false
---

パッとググっても出てこなかったので

- [Tagging Your Amazon EC2 Resources - Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#tag-restrictions)

> The allowed characters across services are: letters, numbers, and spaces representable in UTF-8, and the following characters: + - = . _ : / @.

- `%` が使えないのでURLエスケープはできない
- ただし、`+`, `=` は使えるので base64 は使える
