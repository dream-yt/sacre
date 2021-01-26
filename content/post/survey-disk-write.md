---
title: "DiskへのWriteが重そうな処理を特定する"
slug: survey-disk-write
date: 2021-01-26T10:54:23+09:00
draft: false
author: sakamossan
---

やたら処理が遅い場合の調査で、writeが頻繁に走ってないかを確認する。

### まず疑わしい処理が本当にwriteが多いことを確認する

- `$ dstat --top-io -d 5` をたたいておいて
- 目星をつけたプロセスを走らせる

ioしている容量が見れるようになる

```
$ dstat --top-io -d 5
----most-expensive---- -dsk/total-
     i/o process      | read  writ
bash       3681B  230B| 182k 4174k
                      |   0     0
mysqld     2499k   39M|   0  5734B
perl       2558k   73M|   0  6554B
mysqld     2548k   52M|   0  6554B
perl       2556k   73M|   0     0
perl       4025k   97M|   0    42k
mysqld     2548k   51M|   0     0
                      |   0  1638B
                      |   0  5734B
                      |   0     0
                      |   0  4915B
mysql_insta 345k   23M|   0    25M
mysqld     2499k   39M|   0    58M
mysqld       50k   26M|   0    51M
perl       2556k   73M|   0    42M
mysqld     2548k   51M| 819B   81M
perl       2556k   73M|   0    69M
mysqld     1038k   26M|   0    37M
mysqld     1510k   37M|   0    69M
```

### どんなwriteをしているか

straceでとっておいて、あとからgrepする

```
$ sudo strace -f -p {{ pid }} -o /tmp/strace.log
```

```
$ grep 'write' mysql.strace.log | less
13047 write(1, "/usr/bin/mysql_install_db\n", 26 <unfinished ...>
12879 write(3, "[mysqld]\ndatadir=/tmp/z6B56Iok0v"..., 158) = 158
13054 <... write resumed> )             = 159
13055 write(1, "IP address of localdev.fout.loca"..., 47 <unfinished ...>
13053 write(5, "'Y') COLLATE utf8_general_ci DEF"..., 4096 <unfinished ...>
13053 <... write resumed> )             = 4096
13053 <... write resumed> )             = 4096
13053 <... write resumed> )             = 4096
13053 write(5, "d,\"\n  \"MYSQL_ERRNO INTEGER,\"\n  \""..., 4096 <unfinished ...>
13053 write(5, "e_pfs = 1, @cmd, 'SET @dummy = 0"..., 4096 <unfinished ...>
```
