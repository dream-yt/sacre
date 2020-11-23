---
title: "VS Codeでインデントをハードタブにする"
slug: vscode-using-hardtab
date: 2020-11-07T21:59:28+09:00
draft: false
author: sakamossan
---

この設定にするとTabキーでハードタブが挿入される

```
"editor.insertSpaces": false
```

たとえば(pep8違反だが)Pythonだけで適用したい場合は下記のように書く

```json
    "settings": {
      "[python]": {
        "editor.insertSpaces": false,
    },
```