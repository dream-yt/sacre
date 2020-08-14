---
title: "dockerコンテナ内でstraceを使う"
date: 2018-10-24T23:36:47+09:00
author: sakamossan
author: sakamossan
draft: false
---

docker runに起動オブションをつけないとstraceは実行できない
これはセキュリティの見地からdocker内では呼んで良いシステムコールが制限されているため

以下のページで起動オプションについてのメモが記載されている

- [» Running Strace in Docker](http://blog.johngoulah.com/2016/03/running-strace-in-docker/)


#### cap-add

`SYS_PTRACE` を使って良い状態にするにはこちらを指定する

> If you are using secconf, there are a couple of things you can pass to docker run to loosen up this security policy. To allow strace specifically, you enable the system call that it relies upon to get its information (ptrace):

```
--cap-add SYS_PTRACE
```


#### security-opt

ほかにもシステムコールを制御する仕組みがあるようだ
オルタナティブとして以下のようなオブションの渡し方があるようだ

> This whole paradigm is in fact documented but none of my original searches turned up these pages. In addition to disabling ptrace, there are a slew of other system level commands that you may (or may not) need that aren’t on the docker whitelist of allowed system calls. The list of calls can be adjusted very granularly by feeding docker a json file defining your security options. Or if you are feeling up for it, you can re-enable all of them in one fell swoop with this option to docker run:

```
--security-opt seccomp:unconfined
```

このオプションをつけなくても動くかどうかは確認しておいた方がよさそう
