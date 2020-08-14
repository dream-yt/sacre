---
title: "Lambdaでcallbackを呼んでるのにタイムアウト扱いになる場合"
date: 2018-11-24T12:47:49+09:00
draft: false
author: sakamossan
---

lambdaはcallbackが呼ばれても、イベントループが残っていたらプロセスを待機させてしまう。使用しているライブラリがコネクションをポーリングしていたりすると、そのイベントループが延々残ってしまってプロセスが終了せず、その結果callbackを時間内に呼んでるのにタイムアウトエラーになってしまう状態が発生する

そういう場合は`callbackWaitsForEmptyEventLoop`を`false`にすればよい

```ts
async function f (
  event: APIGatewayEvent,
  context: Context,
  callback: Callback,
) => {
  context.callbackWaitsForEmptyEventLoop = false;
  callback(null, { statusCode: 200, body: response });
}
```

> callbackWaitsForEmptyEventLoop
> デフォルト値は True です。このプロパティはコールバックメソッドのデフォルト動作を変更する場合にのみ使用できます。デフォルトでは、コールバックはイベントループが空になるまで待機してから処理を停止し、呼び出し元に結果を返します。このプロパティを false に設定して、イベントループにイベントがある場合でも、callback が呼び出されたすぐ後に処理を停止するように AWS Lambda にリクエストできます。


### 参考

- [AWS Lambda Context Object in Node.js - AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/nodejs-prog-model-context.html)
