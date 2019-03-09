---
title: "serverlessのcors対応"
date: 2019-03-09T19:11:52+09:00
draft: false
---

s3に静的htmlをホスティングしてlambda/apigatewayからデータを取得する形でやろうとすると、当然s3とlambda / apigatewayのドメインが異なるのでcors対応が必要になる。serverlessのcors対応はあまりこなれていなくて何箇所かいじる必要がある。


## preflightリクエストをさばくための設定

```yaml
getProduct:
handler: handler.getProduct
events:
    - http:
        path: product/{id}
        method: get
        cors: true # <-- CORS!
```

cors環境だとブラウザはサーバへのリクエストに逐次preflightリクエストを行うようになる。preflightリクエストとはブラウザがサーバのCORS設定を問い合わせるためのもので、サーバがこの問い合わせに未対応の場合、ブラウザはpreflightリクエストを403と判断して後に控えていた本チャンのリクエストをサーバに送ってくれない。

CORS設定とは主に `Access-Control-Allow-Origin` ヘッダに入ってるドメインを見て、クライアントは自分が許可されたオリジン(ドメイン)かどうかを判断するあたり。もちろん許可されたドメインでなかったら403として処理する。

`cors: true` の設定を入れると、preflightリクエストへのレスポンスをしてくれるようになる。


## 本チャンのリクエストをさばくための設定

```js
const response = {
    statusCode: 200,
    headers: {
        'Access-Control-Allow-Origin': '*',   // <-- CORS!
        'Access-Control-Allow-Credentials': true,
    },
    body: JSON.stringify({a: 1}),
};
callback(null, response);
```

preflightリクエストだけでなく、すべてのレスポンスヘッダにCORS設定を入れて返す必要がある(そうしないとブラウザは403としてしまう)。そのためのレスポンスヘッダをアプリ側でも対応しないといけない。


## 認証付きのエンドポイントへの対応

serverlessでauthorizersを使っている場合は必要な対応

```yaml
resources:
    Resources:
        GatewayResponseDefault4XX:
        Type: 'AWS::ApiGateway::GatewayResponse'
        Properties:
            ResponseParameters:
            gatewayresponse.header.Access-Control-Allow-Origin: "'*'"
            gatewayresponse.header.Access-Control-Allow-Headers: "'*'"
            ResponseType: DEFAULT_4XX
            RestApiId:
            Ref: 'ApiGatewayRestApi'
```

serverlessで認証を設定するとAPIGateway上でjwtトークンの検証などを行ってくれるようになるが、この検証が失敗(つまり認証失敗)した場合にAPIGatewayはCORS設定が入っていないレスポンスをブラウザに返してしまう。これはブラウザ側からすると認証が失敗しているのかそれともCORS設定が未対応のサーバなのかが判断ができないため問題になる。

4xx系のレスポンスの場合、ヘッダにCORS設定を入れて返すようにする必要があるのでそのための設定をCloudFormation形式で書き足しておくことになる


## 参考

- [Your CORS and API Gateway survival guide (元ネタ)](https://serverless.com/blog/cors-api-gateway-survival-guide/)
- [CORSまとめ - Qiita](https://qiita.com/tomoyukilabs/items/81698edd5812ff6acb34)
