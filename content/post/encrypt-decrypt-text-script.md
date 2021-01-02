---
title: "文字列をopensslで暗号化/復号するbashスクリプト"
slug: encrypt-decrypt-text-script
date: 2021-01-02T18:07:30+09:00
draft: false
author: sakamossan
---

セキュリティ的にあんまり褒められたものではないが、
気持ち平文で保存したくないデータを手元に置いとくのとかには便利。

処理のコア部分はこんな感じになった。

```bash
read -sp "enter password: " password

function encrypt () {
    openssl aes-256-cbc -e \
        -in <(echo $body) \
        -pass pass:$password  \
        | base64
}

function decrypt () {
    openssl aes-256-cbc -d \
        -in <(echo $body | base64 -d) \
        -pass pass:$password
}
```

- `$body` は暗号化したい文字列か、復号したいbase64
- `$password` は read コマンドで取得する

## readコマンド

```bash
read -sp "enter password: " password
```

- `-p` プロンプトで入力した文字列を password 変数に入れてくれる
- `-s` プロンプトで入力してる文字を表示しないように

## 参考

- [opensslコマンドで簡単なファイル暗号化 - Qiita](https://qiita.com/ikuwow/items/1cdb057352c06fd3d727)
- [linux - How to use password argument in via command line to openssl for decryption - Super User](https://superuser.com/questions/724986/how-to-use-password-argument-in-via-command-line-to-openssl-for-decryption)


## gist

- [文字列をopensslで暗号化/復号するbashスクリプト](https://gist.github.com/sakamossan/91e95b39c6301d337dfd402efa71d729)
