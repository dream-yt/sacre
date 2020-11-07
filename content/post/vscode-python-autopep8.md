---
title: "vscodeのformatOnSaveでPython/autopep8を使って整形する"
date: 2020-11-07T22:09:07+09:00
draft: false
author: sakamossan
---

自動でフォーマットを効かせる最低限の設定

```json
    "settings": {
      "[python]": {
        "editor.formatOnSave": true
    },
    "python.formatting.autopep8Path": "autopep8",
    "python.formatting.autopep8Args": [
      "--aggressive",
      "--aggressive"
    ]
```

## 参考

公式のドキュメントがトラブルシューティングを提供していて親切だった

- [Editing Python Code in Visual Studio Code](https://code.visualstudio.com/docs/python/editing#_formatting)
- [autopep8 · PyPI](https://pypi.org/project/autopep8/)