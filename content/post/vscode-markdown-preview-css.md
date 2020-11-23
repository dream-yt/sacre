---
title: "vscodeのMarkdownPreviewにカスタムCSSをあてる"
slug: vscode-markdown-preview-css
date: 2019-09-18T16:25:00+09:00
draft: false
author: sakamossan
---

vscodeのマークダウンプレビューは便利だけど、スタイリングをちょっと修正したかったので  
やりかたをググったら以下の記事が出てきた

- [Visual Studio Code の CSS を見やすくカスタマイズしてみました - Qiita](https://qiita.com/08thse/items/205eea7ed85188ae38bf)

スタイリングはこの記事に書いてあるので満足したが、vscodeの設定の仕様が変わっていて  
この記事通りに設定しても動作しなくなっていたので、仕様変更後の設定の仕方をメモ

## 設定

```json
    "markdown.styles": ["vscode-markdown-preview.css"]
```

ファイル名を設定する条件が以下のようになっている

- プロジェクト内のファイルパスを指定しないといけない
- 相対パスで指定しないといけない
- 配列で指定

パス云々はセキュリティ起因の仕様変更だったようだ  
`プロジェクト内のファイルパス` とある通りグローバルでの設定はできなくなっている

プロジェクトごとにcssファイルを設定しないといけなくなっていて面倒


## その他

元の記事で紹介されていたcssは以下のようなもの

```css
h1 {
    padding-bottom: 0.3em;
    line-height: 1.2;
    border-bottom-width: 1px;
    border-bottom-style: solid;
    border-bottom-color: whitesmoke;
}

h2 {
    padding-bottom: 0.3em;
    line-height: 1.2;
    border-bottom-width: 1px;
    border-bottom-style: solid;
    border-bottom-color: whitesmoke;
}

h3 {
    text-decoration: underline;
}
```

以下の点がうれしかった

- h2 と h3 の区別がつきやすくなっている
- h3 に下線がひかれている
