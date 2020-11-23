---
title: "200が返ってこないURLを見つけるワンライナー"
slug: find-non-200pk-url-oneliner
date: 2019-02-28T08:36:33+09:00
draft: false
author: sakamossan
---

- `./urllist.txt` にはURLのリストが入ってるとして
- そのなかから404とかになってるURLを見つけたい場合

以下のコマンドでダメなURLだけ表示してくれる

```bash
$ cat ./urllist.txt | perl -MLWP::Simple -wnlE 'head($_) or say'
```


## SSL

LWPの使うSSL証明書が古くなっていると以下のようなエラーとなる

> 500 Can't verify SSL peers without knowing which Certificate Authorities to trust

Mozilla::CAをsudoで入れればよい (入ってればLWPが勝手にそっちを使ってくれるようだ)

```bash
$ sudo cpanm Mozilla::CA
```


## 参考

- [LWP::Simple - LWP への簡単な手続き的インターフェース - perldoc.jp](http://perldoc.jp/docs/modules/libwww-perl-5.813/LWP/Simple.pod)
