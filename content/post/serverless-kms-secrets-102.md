---
title: "serverless-kms-secrets を導入する手順2"
slug: serverless-kms-secrets-102
date: 2019-09-07T18:28:17+09:00
draft: false
author: sakamossan
---

こちらの使い方

- [nordcloud/serverless-kms-secrets: 🔑🔐☁️ Serverless plugin to encrypt variables with KMS](https://github.com/nordcloud/serverless-kms-secrets)

## インストール

```console
$ npm install --save-dev serverless-kms-secrets
```

## CMKを生成

kmsでCMK(マスターキーのようなもの)を作成
ポリシーの設定など細かく制御しようとすると大変なので、コンソール画面からポチポチやる

大まかに以下の2つが適正に設定できていればよい

- キー管理者 (CMKの設定をいじれる/削除できるひと)
- キー使用者 (暗号/復号処理ができるひと)

なお、CMKでは4KB以上のデータが暗号化できないはず(データキーを使う)だが、それ以上長いものがどうなるかは確認していない


## serverless.yml に組み込み

- プラグインのロード
- 暗号化したCMKのkey-id/暗号化された変数を書いておくymlファイルの所在の設定
- lambdaに復号の権限をつける
- 環境変数に暗号化された変数を注入するように

```diff
plugins:
   - serverless-prune-plugin
   - serverless-plugin-tracing
+  - serverless-kms-secrets

 provider:
   name: aws
@@ -21,7 +22,13 @@ provider:
         - xray:PutTraceSegments
         - xray:PutTelemetryRecords
       Resource: "*"
+    - Effect: Allow
+      Action:
+      - kms:Decrypt
+      Resource: ${self:custom.kmsSecrets.keyArn}
 custom:
+  kmsSecrets: ${file(kms-secrets.${opt:stage, self:provider.stage}.${opt:region, self:provider.region}.yml)}

@@ -68,4 +68,5 @@ functions:
           # UTC
           rate: cron(10 * * * ? *)
           enabled: true
+     environment: ${self:custom.kmsSecrets.secrets}
```

## データを暗号化

コマンドはこんな感じ

```console
$ serverless encrypt --help
Plugin: kmsSecretsPlugin
encrypt ....................... Encrypt variables to file
    --name / -n (required) ............. Name of variable
    --value / -v (required) ............ Value of variable
    --keyid / -k ....................... KMS key Id
```

##### 例

```bash
serverless encrypt --stage dev \
  --name SLACK_WEBHOOKURL \
  --value 'https://hooks.slack.com/services/xxxxxxxx' \
  --keyid 'xxxxxxxx-f24e-4dc0-b639-2eee249d5be8'
```

初回だけ`--keyid`オプション(CMKのID)が必要


## 復号化テスト

復号化できるか確認するときは以下のコマンドで一覧できる

```console
$ serverless decrypt --stage dev

...
```

## コードに組み込み

こんな感じで使うようにした

```ts
const aws = require('aws-sdk');

export async function getSecretFromKms(key: string) {
  // TODO invoke local 経由の実行時用にローカル環境では環境変数を読むようにする
  const kms = new aws.KMS({
    apiVersion: '2014-11-01',
    region: 'ap-northeast-1',
  });
  const data = await kms
    .decrypt({
      CiphertextBlob: Buffer.from(process.env[key], 'base64'),
    })
    .promise();
  return String(data.Plaintext);
}
```

```ts
    const url = await getSecretFromKms('SLACK_WEBHOOKURL');
```
