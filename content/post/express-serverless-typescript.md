---
title: "lambda/typescriptでexpressを使う"
date: 2019-02-23T12:02:54+09:00
draft: false
author: sakamossan
---

express普通に便利なのでawslabs謹製のツールから使う

- [awslabs/aws-serverless-express](https://github.com/awslabs/aws-serverless-express)

> Run serverless applications and REST APIs using your existing Node.js application framework, on top of AWS Lambda and Amazon API Gateway


## 使い方

- expressのappを生成して、ルーティングを設定

```ts
import { APIGatewayEvent, Callback, Context, Handler } from 'aws-lambda';
import * as awsServerlessExpress from 'aws-serverless-express';
import Express from 'express';

const app = Express();

app.get('/*', (req: Express.Request, res: Express.Response) => {
  const { method, path, query } = req;
  return res.send(JSON.stringify({ method, path, query }));
});

const server = awsServerlessExpress.createServer(app);

export const webapi: Handler = (event: APIGatewayEvent, context: Context) => {
  awsServerlessExpress.proxy(server, event, context);
};
```

### example

こちらを参考にすれば一通りのことはサクッとできそう

- [aws-serverless-express/examples/basic-starter at master · awslabs/aws-serverless-express](https://github.com/awslabs/aws-serverless-express/tree/master/examples/basic-starter)


### deps

この辺をインストールする必要がある

##### devDependencies

```
    "@types/aws-lambda": "^8.10.19",
    "@types/express": "^4.16.1",
```

##### dependencies

```
    "aws-serverless-express": "^3.3.5",
    "express": "^4.16.4"
```


## serverless.yaml

serverless frameworkの方の設定はpath/methodの設定を以下のようにしておく

```yaml
functions:
  WebAPI:
    handler: handler.webapi
    events:
      - http:
          # get/postなんでも受ける
          method: ANY
          # どんなパスでもこのエンドポイントで受けられる
          path: /{any+}
```


## その他

aws-serverless-expressはexpressだけではなく、普通のnode標準のhttpモジュールからも使えるライブラリのようだ

- [aws-serverless-express examples/vanilla-http/index.js](https://github.com/awslabs/aws-serverless-express/blob/master/examples/vanilla-http/index.js)
