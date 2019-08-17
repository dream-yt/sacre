---
title: "serverless-kms-secrets を導入する手順"
date: 2019-08-17T18:28:17+09:00
draft: false
---

こちらの使い方

- [nordcloud/serverless-kms-secrets: 🔑🔐☁️ Serverless plugin to encrypt variables with KMS](https://github.com/nordcloud/serverless-kms-secrets)

## インストール

```console
$ npm install --save-dev serverless-kms-secrets
```

## CMKを生成

kmsでCMKを作成

```console
s$ aws kms create-key --description 'for_some'
{
    "KeyMetadata": {
        "AWSAccountId": "00000000",
        "KeyId": "xxxxxxxx-f24e-4dc0-b639-2eee249d5be8",
        "Arn": "arn:aws:kms:ap-northeast-1:00000000:key/xxxxxxxx-f24e-4dc0-b639-2eee249d5be8",
        "CreationDate": 1566028483.619,
        "Enabled": true,
        "Description": "for_some",
        "KeyUsage": "ENCRYPT_DECRYPT",
        "KeyState": "Enabled",
        "Origin": "AWS_KMS",
        "KeyManager": "CUSTOMER"
    }
}
```

CMKでは4KB以上のデータが暗号化できないはず(データキーを使う)だが、それ以上長いものがどうなるかは確認していない


## serverless.yml に組み込み

- プラグインのロード
- lambdaに復号の権限
- 暗号化に必要なkeyArn

```diff
plugins:
   - serverless-prune-plugin
   - serverless-plugin-tracing
   - serverless-dotenv-plugin
+  - serverless-kms-secrets

 provider:
   name: aws
@@ -21,7 +22,13 @@ provider:
         - xray:PutTraceSegments
         - xray:PutTelemetryRecords
       Resource: "*"
+    - Effect: Allow
+      Action:
+      - KMS:Decrypt
+      Resource: ${self:custom.kmsSecrets.keyArn}
 custom:
+  kmsSecrets:
+    file: ${file(kms-secrets.${opt:stage, self:provider.stage}.${opt:region, self:provider.region}.yml)}
+    keyArn: 'arn:aws:kms:ap-northeast-1:00000000:key/xxxxxxxx-f24e-4dc0-b639-2eee249d5be8'
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

デフォルトの設定だと `kms-secrets.dev.ap-northeast-1.yml` という名前のファイルにBASE64形式で保管された


## 環境変数に暗号化されたデータを組み込み

```diff
functions:
           # UTC
           rate: cron(10 * * * ? *)
           enabled: true
+    environment:
+      SLACK_WEBHOOKURL: ${self:custom.kmsSecrets.file.secrets.SLACK_WEBHOOKURL}
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
      CiphertextBlob: new Buffer(process.env[key], 'base64'),
    })
    .promise();
  return String(data.Plaintext);
}
```

```ts
    let url = await getSecretFromKms('SLACK_WEBHOOKURL');
```
