---
title: "xargs にシェルの関数を渡して並列処理してもらう"
slug: pass-xargs-shell-function
date: 2021-05-07T11:32:05+09:00
draft: false
author: sakamossan
---

普通にやると xargs にはシェルの関数を渡すことはできないが、ちょっと頑張れば xargs で関数を並列で処理させることができる。
普通は xargs ではなく for ループで処理すればいいのだが「この部分の処理だけ並列処理させたい」という場合には、その処理を関数にまとめて xargs に並列化してもらうと手軽で便利だ。


## シェルの関数を渡す

まずシェルで関数を定義する。

```bash
myfunc () {
  local arg1=$1
  ...
}
```

それを export してサブシェルでも `myfunc` を使えるようにする。

```bash
export -f myfunc
```

- [export man page](http://linuxcommand.org/lc3_man_pages/exporth.html)

xargs に `-c`オプションを伴ったbashコマンドとして渡す。

```bash
... | xargs -I{} bash -c "myfunc {}"
``` 

`bash -c` で渡すコマンドはサブシェル扱いになるので export が必要。

## 並列で処理させる

xargs には `-P` オプションがあり、これを指定すると渡した行をそれぞれ並列で処理してくれるようになる。

```bash
... | xargs -P4 -I{} bash -c "myfunc {}"
``` 

- [【 xargs 】コマンド――コマンドラインを作成して実行する：Linux基本コマンドTips（176） - ＠IT](https://www.atmarkit.co.jp/ait/articles/1801/19/news014.html)

マシンのCPUコア数はOSごとにそれぞれ以下のコマンドで調べられる。

#### Linux

```bash
$ cat /proc/cpuinfo | grep processor
processor	: 0
processor	: 1
processor	: 2
processor	: 3
```

#### macos

```bash
$ system_profiler SPHardwareDataType  | grep Cores
      Total Number of Cores: 4
```

- [MacのターミナルでCPUのコア数を確認する方法｜茶トラ猫のエンジニア日記](https://itneko.com/mac-cpu-core/)


## bash が必要

`export -f` は `/bin/sh` の機能にないので `bash` でスクリプトを実行する必要がある。
コンテナ環境とかで `bash` が入っていない場合は使えない。

- [bash - How to export a function in Bourne shell? - Stack Overflow](https://stackoverflow.com/questions/29239806/how-to-export-a-function-in-bourne-shell)


## 参考

- [bash - How to use defined function with xargs - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/158564/how-to-use-defined-function-with-xargs)

