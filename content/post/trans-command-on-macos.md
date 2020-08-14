---
title: "macosでパイプで翻訳してくれるtransコマンドを使う"
date: 2018-11-23T14:18:17+09:00
draft: false
author: sakamossan
---

- [soimort/translate-shell: Command-line translator using Google Translate, Bing Translator, Yandex.Translate, DeepL Translator, etc.](https://github.com/soimort/translate-shell)

### インストール

```bash
brew install gawk  # 依存してるのでmacosの場合必要
sudo wget git.io/trans -O /usr/local/bin/trans
sudo chmod +x /usr/local/bin/trans
```

### 使い方

```
$ trans --help | head -1
Usage:  trans [OPTIONS] [SOURCE]:[TARGETS] [TEXT]...
```

##### 例えば

日本語(`ja`)から英語(`en`)ならこんな感じ

```console
$ echo 最新に更新する | trans ja:en
最新に更新する
(Saishin ni kōshin suru)

Update to latest

「最新に更新する」の翻訳
[ 日本語 -> English ]

最新に更新する
    Update to latest, To update to the latest
```

