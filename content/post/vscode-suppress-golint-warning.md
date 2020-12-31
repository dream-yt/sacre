---
title: "vscodeでgolintの警告を抑制する"
slug: vscode-suppress-golint-warning
date: 2020-12-31T22:31:54+09:00
draft: false
author: sakamossan
---

vscodeでgolangをgolintしながら書いていると、以下のようなwarningが出る。

> exported type Expression should have comment or be unexportedgo-lint

publicなコードには説明が必要。というルールだが小さな関数とかだといちいちやってられないので、このwarningを抑制したい。

こんな設定で警告が消える。

```json
    "go.lintTool": "golint",
    "go.lintFlags": [
      "--exclude=\"\bexported \\w+ (\\S*['.]*)([a-zA-Z'.*]*) should have comment or be unexported\b\""
    ],
```

## 参考

- [How to disable [exported method should have comment or be unexported · Issue #186 · golang/lint](https://github.com/golang/lint/issues/186)
