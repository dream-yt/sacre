---
title: "ドメインからIPアドレスを引くときに、使うDNSサーバを指定する"
slug: specify-dns-server-from-host
date: 2021-03-02T14:58:39+09:00
draft: false
author: sakamossan
---

hostコマンドの第二引数にDNSサーバを指定できる

```console
$ host -a amazon.co.jp 8.8.8.8
Using domain server:
Name: 8.8.8.8
Address: 8.8.8.8#53
Aliases:

amazon.co.jp has address 52.119.168.48
amazon.co.jp has address 52.119.164.121
amazon.co.jp has address 52.119.161.5
amazon.co.jp mail is handled by 10 amazon-smtp.amazon.com.
```

IPアドレスからドメインを引くときはdigで調べられる

```
dig -x 52.119.168.48
```


## 参考

- [【 host 】コマンド――ドメイン名からIPアドレスを調べる：Linux基本コマンドTips（157） - ＠IT](https://www.atmarkit.co.jp/ait/articles/1711/02/news017.html#:~:text=host%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%A8%E3%81%AF%EF%BC%9F,%E3%81%AA%E8%A1%A8%E7%A4%BA%E3%81%8C%E7%89%B9%E5%BE%B4%E3%81%A7%E3%81%99%E3%80%82)
- [【 dig 】コマンド――ドメイン名からIPアドレスを調べる：Linux基本コマンドTips（158） - ＠IT](https://www.atmarkit.co.jp/ait/articles/1711/09/news020.html)
