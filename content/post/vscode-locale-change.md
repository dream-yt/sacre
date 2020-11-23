---
title: "vscodeでエラーメッセージを英語にする"
slug: vscode-locale-change
date: 2018-12-25T14:59:41+09:00
draft: false
author: sakamossan
---

表示言語の設定は設定ファイルとは別ファイル管理になっている

以下のファイルで設定されている

```
~/Library/Application\ Support/Code/User/locale.json
```

localeの値をよしなに変更すれば良い

```js
{
	// VS Code の表示言語を定義します。
	// サポートされている言語の一覧については、https://go.microsoft.com/fwlink/?LinkId=761051 をご覧ください。

	"locale":"en" // VS Code を再起動するまで変更は有効になりません。
}
```

### 参考

- [Visual Studio Code Display Language (Locale)](https://code.visualstudio.com/docs/getstarted/locales)
