---
title: "[ansible x Raspbian] nodejs のインストール"
slug: ansible-Raspbian-install-nodejs
date: 2020-08-28T00:07:02+09:00
draft: false
author: sakamossan
---

ansible-role-nodejs を使うとラズパイでも簡単に入る

- [geerlingguy/ansible-role-nodejs: Ansible Role - Node.js](https://github.com/geerlingguy/ansible-role-nodejs)

一緒に `npm -g install yarn` もしてもらうような最小限の設定

```yaml
  vars:
    nodejs_version: "12.x"
    nodejs_npm_global_packages:
      - yarn
  roles:
    - ansible-role-nodejs
```


### 環境

`Raspbian Buster Lite` で動作

- [Download Raspbian for Raspberry Pi](https://www.raspberrypi.org/downloads/raspbian/)
