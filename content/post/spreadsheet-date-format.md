---
title: "Spreadsheetで日付を文字列フォーマットして表示する"
slug: spreadsheet-date-format
date: 2019-04-26T15:14:18+09:00
draft: false
author: sakamossan
---

TEXT関数を使えばよい

```vb
=TEXT(G11, "m月d日（ddd）")
```

こんな感じで表示される

```
4月22日（月）
```

- ↑ `G11` に日付文字列が入っている場合の例
- `ddd` は曜日を表示するためのやつ


### 参考

- [support.google.com | TEXT - ドキュメント エディタ ヘルプ](https://support.google.com/docs/answer/3094139?hl=ja)
