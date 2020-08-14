---
title: "覚えにくくてもいいようなランダム文字列を生成する"
date: 2019-03-25T16:56:27+09:00
draft: false
author: sakamossan
---


pwgenを使うのが便利

```console
$ pwgen --symbols --secure 12 1
`lJ+b9$"J}Cv
```

pwgenはデフォルトだと覚えやすい感じで生成してくれるので、その辺をオプションでさらにランダムにしてみる

### options

- pw_length 生成する文字列の長さ
- num_pw 生成する個数

> Usage: pwgen [ OPTIONS ] [ pw_length ] [ num_pw ]

デフォルトだとpwgenは紛らわしい文字や連続した文字などを生成しない
`--secure` オプションで完全にランダムにできる

>  -s or --secure
>	Generate completely random passwords

デフォルトだとpwgenは `;` `&` などの記号を含めない
記号が含まれてもいいので `--symbols` をつける

>  -y or --symbols
>	Include at least one special symbol in the password


### 参考

- [pwgen(1): make pronounceable passwords - Linux man page](https://linux.die.net/man/1/pwgen)
