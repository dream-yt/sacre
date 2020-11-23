---
title: "webpackで、プロジェクトのファイルを@ディレクトリ配下でimportできるような設定"
slug: import-withat-mark-in-typescript-vscode-jest
date: 2019-08-25T15:44:56+09:00
draft: false
author: sakamossan
---

webpackだとsymlink貼ったり `NODE_PATH` をいじったりする必要はない


## 差分

webpack.config.js を変更しないとビルドできない

```diff
   resolve: {
+    alias: { '@': path.resolve(__dirname, './src/') },
     extensions: ['.ts', '.tsx', '.js']
   },
```

正常にビルドできても vscode でエラーになるので
tsconfig.json も設定を入れる必要がある

```diff
+    "baseUrl": "./",
+    "paths": { "@/*": ["src/*"] },
```

jest実行時の設定も必要

```diff
+  "moduleNameMapper": {
+    "^\@/(.*)$": "<rootDir>/src/$1"
+  },
```


## 参考

- [Solve Module Import Aliasing for Webpack, Jest, and VSCode](https://medium.com/@justintulk/solve-module-import-aliasing-for-webpack-jest-and-vscode-74007ce4adc9)

