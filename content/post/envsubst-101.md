---
title: "envsubstを使って環境変数だけでサクッとテンプレート出力する"
date: 2019-03-05T15:20:05+09:00
draft: false
author: sakamossan
---

gettextパッケージに入っているenvsubstコマンドを使うと、テンプレートファイルから環境変数を埋めて出力することができる

- [GNU gettext utilities: envsubst Invocation](https://www.gnu.org/software/gettext/manual/html_node/envsubst-Invocation.html)

### インストール

macの場合は brew で入る

```
$ brew install gettext
$ brew link --force gettext
```

## 例

例えば以下のようなテンプレートファイルがあるとして

```yaml
${ASSET}_status:
    not_null:
        ja: ${ASSET_JA}のステータスを入力してください
        en: Please enter the ${ASSET_EN} status
    uint:
        ja: ${ASSET_JA}のステータスが不正です
        en: Invalid ${ASSET_EN} status
    in:
        ja: ${ASSET_JA}のステータスが不正です
```

こんな感じでenvsubstに流し込むと `${...}` の部分を環境変数で埋めた出力が得られる

```console
$ ASSET=title ASSET_JA=タイトル ASSET_EN=Title envsubst < /tmp/_.tmpl
title_status:
    not_null:
        ja: タイトルのステータスを入力してください
        en: Please enter the Title status
    uint:
        ja: タイトルのステータスが不正です
        en: Invalid Title status
    in:
        ja: タイトルのステータスが不正です
        en: Invalid Title status
```
