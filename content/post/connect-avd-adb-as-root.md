---
title: "androidの仮想デバイス(AVD)にadb rootで接続する"
date: 2020-01-17T15:47:02+09:00
draft: false
author: sakamossan
---

androidの `/data/` 配下など、rootでしかアクセスできない領域のデータを確認する場合に、
adb root する必要がある


## 仮想デバイスの起動

```bash
# 一覧を取得
$ emulator -list-avds
# 起動
$ emulator -avd GoogleAPI_-_Pixel_2_XL_API_29
```


## 接続

**注意**

OSイメージによってadb rootできないものがある
仮想デバイスを作成するときに `Google Play  ~` というのを選ぶとrootできない

> To enable root access, use an emulator image like
>    Google APIs Intel x86 Atom System Image
> not 
>    Google Play Intel x86 Atom System Image

- [android - ADB root is not working on emulator (cannot run as root in production builds) - Stack Overflow](https://stackoverflow.com/questions/43923996/adb-root-is-not-working-on-emulator-cannot-run-as-root-in-production-builds/45668555#45668555)


## 接続

adbコマンドで接続する

```console
$ adb root
restarting adbd as root
$ adb shell
```

```console
1|generic_x86:/ # ls -lah /data/user/
total 8.0K
drwx--x--x  2 system system 4.0K 2020-01-17 15:29 .
drwxrwx--x 45 system system 4.0K 2020-01-17 15:29 ..
lrwxrwxrwx  1 root   root     10 2020-01-17 15:29 0 -> /data/data
```


## 参考

- [Using ADB to interact with the AVD – Automation Guide](https://seleniumbycharan.com/2016/08/07/using-adb-to-interact-with-the-avd/)
