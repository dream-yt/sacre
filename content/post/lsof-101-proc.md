---
title: "lsofでプロセスが開いてるfdを一覧する"
slug: lsof-101-proc
date: 2021-01-18T15:03:35+09:00
draft: false
author: sakamossan
---

ほとんどコンテナとかFaasでの作業になるとこういうのはどんどん忘れていく。

たとえば iTerm のプロセスが触ってるファイルディスクリプタを見たい場合。

```console
$ sudo lsof -c iTerm2 | tail
iTerm2  512 mossan   37      PIPE 0x2766560a9b355b8c     16384                     ->0xe4dac32420839ea8
iTerm2  512 mossan   38u      REG                1,7    167936            30430764 /private/var/folders/qx/k9kjj2sj36v87g5zndb0j72r0000gp/C/com.googlecode.iterm2/com.apple.metal/31001/libraries.data
iTerm2  512 mossan   39u      REG                1,7      1780            30749410 /private/var/folders/qx/k9kjj2sj36v87g5zndb0j72r0000gp/C/com.googlecode.iterm2/com.apple.metal/31001/libraries.list
iTerm2  512 mossan   40      PIPE 0xbcaff721142d0d16     16384                     ->0xb42da808f8919f05
iTerm2  512 mossan   41      PIPE 0xb42da808f8919f05     16384                     ->0xbcaff721142d0d16
iTerm2  512 mossan   42u      REG                1,7     13328            30749501 /Users/mossan/Library/Saved Application State/com.googlecode.iterm2.savedState/window_1.data
iTerm2  512 mossan   43w      REG                1,7      5044            30749509 /Users/mossan/Library/Saved Application State/com.googlecode.iterm2.savedState/windows.plist
iTerm2  512 mossan   44u      REG                1,7    360272            30749573 /Users/mossan/Library/Saved Application State/com.googlecode.iterm2.savedState/window_2.data
iTerm2  512 mossan   45u      CHR               15,1    0t7740                 586 /dev/ptmx
iTerm2  512 mossan   46u      CHR               15,2  0t144325                 586 /dev/ptmx
```

fdのタイプ(uとかwとか)についてはこちらにまとまっていた

- [lsof:オープンしているファイルを調べる – Siguniang's Blog](https://siguniang.wordpress.com/2012/02/29/lsof-and-open-file/#%E5%87%BA%E5%8A%9B%E7%B5%90%E6%9E%9C%E3%81%AE%E7%A2%BA%E8%AA%8D)

