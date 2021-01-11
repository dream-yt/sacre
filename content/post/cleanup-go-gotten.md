---
title: "go get したものを消す"
slug: cleanup-go-gotten
date: 2021-01-11T10:42:14+09:00
draft: false
author: sakamossan
---

go clean で入れたものを消すことができる。

```console
$ go clean -i -n github.com/sakamossan/mymy
cd /Users/sakamossan/go/src/github.com/sakamossan/mymy
rm -f mymy mymy.exe mymy.test mymy.test.exe main main.exe
rm -f /Users/sakamossan/go/bin/mymy
```

それぞれのフラグはこんな役割。

> The -i flag causes clean to remove the corresponding installed
> archive or binary (what 'go install' would create).

> The -n flag causes clean to print the remove commands it would execute,
> but not run them.

`-n` オプションはdryrunのような役割。
これを実行してから `-i` オプションだけで実行すれば安心。

```console
$ go clean -i github.com/sakamossan/mymy
```

なお、`$GOPATH` 配下のソースは消してくれないのでそっちは自分で消す。

```console
$ rm -rf $GOPATH/src/github.com/sakamossan/mymy
```


## 参考

- [Go get でインストールしたパッケージをきれいに削除する方法 - Qiita](https://qiita.com/Asya-kawai/items/4883a554ec50eaade51a)

