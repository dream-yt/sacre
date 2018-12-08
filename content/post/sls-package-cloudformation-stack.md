---
title: "serverless deploy で生成されるリソースを事前に確認する"
date: 2018-12-08T23:48:03+09:00
draft: false
---

serverlessのプラグインを使うと色々なリソースを勝手に作ってくれたりして便利だが、実行するまでプラグインのyaml設定が思い通りになっているか分からなくて、dryrunみたいなことがしたい場合がある。が、slsコマンドにdryrunオプションはない

代わりに`serverless package`コマンドがあるので、これを使うと生成されるcloudformationのjsonを見ることが出来るのでこれを使う


```bash
$ serverless package --package ~/Desktop && \
    cat ~/Desktop/cloudformation-template-update-stack.json \
    | yq -y . | pbcopy  # jsonは見にくいのでyamlに整形する
```

### 参考

- [WIP: Add DRYrun support by johncmckim · Pull Request #1808 · serverless/serverless](https://github.com/serverless/serverless/pull/1808)
- [--noDeploy -> serverless package · Issue #1884 · serverless/serverless](https://github.com/serverless/serverless/issues/1884)
