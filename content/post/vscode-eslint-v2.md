---
title: "vscode-eslint(v2)の設定をする"
slug: vscode-eslint-v2
date: 2020-04-10T15:58:01+09:00
draft: false
author: sakamossan
---

こんな設定になった

```json
{
  "[javascript]": {
    "editor.codeActionsOnSave": {
      "source.fixAll.eslint": true
    },
    "editor.tabSize": 2
  },
  "eslint.enable": true,
  "eslint.alwaysShowStatus": true,
  "eslint.debug": false,
  "eslint.format.enable": true,
  "eslint.lintTask.enable": true,
  "eslint.workingDirectories": [
    {
      "mode": "auto"
    }
  ]
}
```


### editor.codeActionsOnSave

vscode-eslintはv2からこんな設定になっている

- https://github.com/microsoft/vscode-eslint#release-notes

```json
"editor.codeActionsOnSave": {
  "source.fixAll.eslint": true
},
```

### eslint.alwaysShowStatus

動作確認をするときに役に立った
OUTPUTパネルを簡単に見れるようになる

### eslint.workingDirectories

`{ "mode": "auto" }` がよい (v2からの設定)

> { "mode": "auto" } (@SInCE 2.0.0): instructs ESLint to infer a working directory based on the location of package.json, .eslintignore and .eslintrc* files. This might work in many cases but can lead to unexpected results as well.


## 参考

- [ESLint fails to load plugins when using ESLint 6.x · Issue #696 · microsoft/vscode-eslint](https://github.com/microsoft/vscode-eslint/issues/696)
- [fix(jest): fix "jest/globals" is unknown by binchik · Pull Request #52 · anvilabs/eslint-config](https://github.com/anvilabs/eslint-config/pull/52/files)

## デバッグ

うまく動かない時は以下を確認

- 全体の設定とワークスペースごとの設定を確認する
  - 古い設定で `"eslint.enable": false` とかが効いてると動かない
- コンソールの表示(OUTPUT/PROBLEM)を確認する
  - vscode-eslintはOUTPUT `INFO` ログにエラーメッセージが出て止まっていた
