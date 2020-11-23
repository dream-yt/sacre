---
title: "JavaScript heap out of memory になんとなくで対処する場合とchromeでデバッグする場合"
slug: javaScript-heap-out-of-memory
date: 2018-12-16T12:05:36+09:00
draft: false
author: sakamossan
---

例えばwebpackの処理で以下のエラーが出た場合の話

```bash
$ serverless deploy --function App --stage prod
```

```console
Serverless: Bundling with Webpack...

...中略...

FATAL ERROR: CALL_AND_RETRY_LAST Allocation failed - JavaScript heap out of memory
 1: node::Abort() [~/.nodebrew/node/v8.10.0/bin/node]
 2: node::FatalException(v8::Isolate*, v8::Local<v8::Value>, v8::Local<v8::Message>) [~/.nodebrew/node/v8.10.0/bin/node]

...中略...

12: v8::internal::Builtin_Impl_HandleApiCall(v8::internal::BuiltinArguments, v8::internal::Isolate*) [~/.nodebrew/node/v8.10.0/bin/node]
13: 0x373ff9d842fd
```

## なんとなくで対処すればいい場合

メッセージ通りにheapが足りていないのでオプションを足せば逃げられる

```bash
$ node --max_old_space_size=2048 serverless deploy
```


## 原因を調べたい場合

きちんと原因を探ろうとする場合は以下のコマンドで調べられる

```
$ node --max_old_space_size=512 --expose-gc --inspect serverless deploy
```

叩くとURLが表示されるので、それをchromeで開くとデバッガが起動する。ステップ実行しながらどの辺の処理でヒープが膨らんでるかを見ることが出来たり「これ落ちる寸前です」というところで止めてくれてスゴイ便利

ちなみに今回は [googleapis](https://github.com/googleapis/google-api-nodejs-client) のソースマップを生成するところであれになって死んでいました

### 参考

- [Debugging Memory Leaks and Memory Bloat in Node.js – Tech @Reside](https://tech.residebrokerage.com/debugging-node-js-memory-problems-d450787d9253)

