---
title: "bash でパスの末尾に `/` がついてたら取り除く"
slug: normalize-path-trailing-slash
date: 2022-02-18T18:57:48+09:00
draft: false
author: sakamossan
---

引数でパスを渡してもらうときとかに、入力を正規化するために使う。

```bash
for OPT in "$@"; do
    case $OPT in
        '--csvpath-prefix')
            csvpath_prefix=${2%/}
            shift 2
            ;;
    esac
done
echo $csvpath_prefix
```

この部分。bashの機能で変数の一部を切り出せる、末尾に `/` がついている場合のみ取り除くことができる。

```bash
csvpath_prefix=${2%/}
```

## 参考

- [Shell Parameter Expansion (Bash Reference Manual)](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html)
