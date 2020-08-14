---
title: "psコマンドでメモリ使用量, CPU使用量でソートする"
date: 2020-02-12T09:37:33+09:00
draft: false
author: sakamossan
---

`--sort` オプションがある

## 例

`-%mem` は降順、メモリ使用量という意味

```bash
root@92b0f68c3eb3:/# ps aux --sort -%mem | head
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.1  18240  3236 pts/0    Ss   00:20   0:00 /bin/bash
root        20  0.0  0.1  34424  2780 pts/0    R+   00:22   0:00 ps aux --sort -%mem
root        21  0.0  0.0   4384   668 pts/0    S+   00:22   0:00 head
```

`%cpu` にするとCPU使用率

```bash
root@92b0f68c3eb3:/# ps aux --sort -%cpu
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root        24  108  0.1  16088  3768 pts/0    R    00:22   0:06 perl -E while (1) {}
root         1  0.0  0.1  18240  3236 pts/0    Ss   00:20   0:00 /bin/bash
root        27  0.0  0.1  34424  2868 pts/0    R+   00:22   0:00 ps aux --sort -%cpu
root        28  0.0  0.0   4384   756 pts/0    S+   00:22   0:00 head
```
