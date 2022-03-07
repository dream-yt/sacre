---
title: "bashで{標準,エラー}出力にタイムスタンプをつける"
slug: print-timestamp-on-bash-script-logging
date: 2022-02-23T17:02:39+09:00
draft: false
author: sakamossan
---

スクリプトの先頭でこんな感じで exec をしておけばよい。

```bash
function addtimestamp() {
    while IFS= read -r line; do
        printf '%s %s\n' "[$(date +"%Y-%m-%d %H:%M:%S")]" "$line";
    done
}
readonly scriptname=$(basename ${0%.sh})
exec 1> >(addtimestamp | tee -a "/tmp/$scriptname-stdout.log")
exec 2> >(addtimestamp | tee -a "/tmp/$scriptname-stderr.log")
```

### 参考

- [linux - How to add a timestamp to bash script log? - Server Fault](https://serverfault.com/questions/310098/how-to-add-a-timestamp-to-bash-script-log)
- [Bashシェルスクリプトでログ出力をシンプルに実現する方法 | ゲンゾウ用ポストイット](https://genzouw.com/entry/2020/01/06/120027/1845/)
