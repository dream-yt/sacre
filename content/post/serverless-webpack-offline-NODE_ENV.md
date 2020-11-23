---
title: "serverless-webpack のプロジェクトで serverless-offline 実行時に NODE_ENV を設定する"
slug: serverless-webpack-offline-NODE_ENV
date: 2019-08-25T15:06:15+09:00
draft: false
author: sakamossan
---

地味だがハマった。ちょうどおんなじことをしていた人の解決策が見つかって助かった

- [MNML](https://blog.70-10.net/2019/06/20/serverless-webpack-node_env/)

↑の方法でうまくいった

### つまり原因は

こういうことらしい

- webpack はNODE_ENVをデフォルトで `development` にする
- serverless-offline は webpack をキックする時に NODE_ENV をセットせず、デフォルトになっている?

しかし、シェル変数でなく環境変数( `export NODE_ENV` )として設定していたので、環境変数NODE_ENVは引き継がれそうなものだが、serverless-offline がunsetしているのだろうか?


## 差分

とにかくにも、こんな感じでNODE_ENVを設定できるようになる

#### .envrc

```diff
+ export NODE_ENV=local
```

#### serverless.yml

```diff
  stage: ${opt:stage, 'dev'}
+  environment:
+    NODE_ENV: ${env:NODE_ENV}
```

##### webpack.config.js

```diff
+  plugins: [new webpack.EnvironmentPlugin(slsw.lib.serverless.service.provider.environment)],
}
```
