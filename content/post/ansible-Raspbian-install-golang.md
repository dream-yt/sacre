---
title: "[ansible x Raspbian] golang のインストール"
slug: ansible-Raspbian-install-golang
date: 2020-08-28T00:26:50+09:00
draft: false
author: sakamossan
---

ansible-role-golang を使うとこのロールの設定だけで入る

- [fubarhouse/ansible-role-golang: Installs the Go programming language and packages on Mac & Linux (Ubuntu, CentOS)](https://github.com/fubarhouse/ansible-role-golang)

```yaml
  vars:
    # golang
    go_version: 1.13.5
    GOPATH: /usr/local/lib/go
    GOOS: linux
    GOARCH: arm
    # ソースからインストールするためにいったんgo1.4を入れて、v1.13を入れる
    build_go_from_source: true
    install_go_bootstrap: true
    GOROOT_BOOTSTRAP: /usr/local/bin/go1.4
    # 一緒にgo getもするなら下記の設定でできる
    # go_get:
    #   - name: go-check-plugins
    #     url: github.com/mackerelio/go-check-plugins
  roles:
    - ansible-role-golang
```


### 環境

`Raspbian Buster Lite` で動作したもの

- [Download Raspbian for Raspberry Pi](https://www.raspberrypi.org/downloads/raspbian/)
