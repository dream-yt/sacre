---
title: "vscodeのextensionをvsixファイルからインストールする"
date: 2019-06-02T16:42:13+09:00
draft: false
author: sakamossan
---


コマンドラインからcodeコマンドでできる

```bash
$ code --install-extension ./auto-collapse-explorer-0.0.2.vsix
```

- `--install-extension` オプションが必要
- `.vsix` ファイルを引数にとる


##### 再起動

vscodeの再起動が必要(コマンドパレットからやるとラク)

- `> Reload Window`

### 参考

- [How to install? · Issue #6 · hoovercj/vscode-api-playground](https://github.com/hoovercj/vscode-api-playground/issues/6)
- [visual studio code - How to restart VScode after editing extension's config? - Stack Overflow](https://stackoverflow.com/questions/42002852/how-to-restart-vscode-after-editing-extensions-config)


### その他

ファイルツリービューで、node_module配下のファイルが多くて鬱陶しかったんですけど、以下のプラグインが便利でよかった
ファイルを閉じたらツリービューでもそのディレクトリを閉じてくれる

- [vscode-api-playground/AutoCollapseExplorer at master · hoovercj/vscode-api-playground](https://github.com/hoovercj/vscode-api-playground/tree/master/AutoCollapseExplorer)
