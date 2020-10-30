---
title: "VSCodeでワークスペースのpythonファイルだけオートフォーマットを無効にする"
date: 2020-10-15T21:53:43+09:00
draft: false
author: sakamossan
---

半年に1回くらい設定してるのでメモ

settingsからworkspaceの設定を開き、以下のように設定すればよい

```json
  "settings": {
    "[python]": {
      "editor.formatOnSave": false
    }
  }
```

- [Turn off auto formatting for json files in Visual Studio Code - Stack Overflow](https://stackoverflow.com/questions/38057725/turn-off-auto-formatting-for-json-files-in-visual-studio-code)

プロジェクトがハードタブになっていても大丈夫になる