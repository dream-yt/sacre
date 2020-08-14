---
title: "There is no document formatter for 'sql'-files installed"
date: 2019-01-22T12:52:05+09:00
draft: false
author: sakamossan
---

vscodeを使っている。SQLファイルは保存時にフォーマットされるようしているが、
ある日突然保存時フォーマットが聞かなくなった

vscodeのコマンドパレットから `Document Format` を選択しても以下のエラーでフォーマットされない

> There is no document formatter for 'sql'-files installed

vscodeのsettings.jsonには以下のように設定していて、瑕疵はなさそうに思えた

```json
"[sql]": {
    "editor.formatOnSave": true,
    "editor.formatOnPaste": true
},
```


## 解決

`"editor.formatOnSave"` を1回trueにして、すぐにfalseに戻したら
件のエラーは出なくなった

ちょっとよく分からない
