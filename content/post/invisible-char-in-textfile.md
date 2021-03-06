---
title: "テキストに不可視な文字が入っている場合の対処"
slug: invisible-char-in-textfile
date: 2019-02-14T17:11:00+09:00
draft: false
author: sakamossan
---

不可視文字には `\t` (タブ) や `\f` (改ページ)など色々ある

環境によってトーフが表示されたりする

- 例
    - エディタでは大丈夫なのにGitHubに投稿するとトーフが表示される

こういう場合はテキストをodコマンドにかけると隠れてる文字がわかる

```console
$ cat /tmp/_
え信じられない
# catだと見えないが \b が隠れてることがわかる
$ cat /tmp/_ | od -c
0000000   え  **  **  っ  **  **  \b  信  **  **  じ  **  **  ら  **  **
0000020   れ  **  **  な  **  **  い  **  **  \n
0000032
```

odコマンドは`-c`オプションをつけると分かりやすい

> -c Output C-style escaped characters.  Equivalent to -t c.

エスケープ文字の一覧はこちらでみられる

`\n`, `\t` はなじみがあるがバックスペースとかはパッと思い出せないので便利

- [エスケープ文字 - Wikipedia](https://ja.wikipedia.org/wiki/%E3%82%A8%E3%82%B9%E3%82%B1%E3%83%BC%E3%83%97%E6%96%87%E5%AD%97)


