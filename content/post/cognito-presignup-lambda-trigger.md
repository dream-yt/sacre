---
title: "cognitoで特定ドメインのGoogleアカウントだけsignUpさせる"
date: 2019-03-23T11:54:52+09:00
draft: false
---

lambda trigger を設定できるのでこの関数の中で可否を判定する

- [Pre Sign-up Lambda Trigger - Amazon Cognito](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-pre-sign-up.html)


## やり方

serverless framework を使うとこんな設定ができる
`trigger: PreSignUp` の設定で、ユーザの新規登録前にチェックができる

```yaml
  SignUpValidation:
    handler: handler.signUpValidation
    memorySize: 128
    events:
      - cognitoUserPool:
          pool: MyPoolId
          trigger: PreSignUp
```

設定できるトリガーは他にも色々ある

- [Customizing User Pool Workflows with Lambda Triggers - Amazon Cognito](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html)


### 注意

- serverless frameworkでは既存のUserPoolをpoolとして設定できない (新規作成のみ)
- すでにPoolを作ってしまっている場合は関数だけ作ってUIから手動で紐付けとなる

新規作成する場合も最低限の設定で作られてしまうので適宜上書きする必要がありそう

- [Serverless Framework - AWS Lambda Events - Cognito User Pool](https://serverless.com/framework/docs/providers/aws/events/cognito-user-pool/#overriding-a-generated-user-pool)


## lambda上での処理の書き方

- 承認する場合は引数で受け取ったeventをcontext.doneに渡す
- 否認したい場合はnullを渡す
  - これで合ってるのかは微妙...
  - [AWS Developer Forums: presignup_signup response - how to deny ...](https://forums.aws.amazon.com/thread.jspa?threadID=246732)

たとえばemailで特定のドメインのみ許可したいという場合は以下のようになる

```ts
import { CognitoUserPoolTriggerEvent, Context } from 'aws-lambda';

export default (event: CognitoUserPoolTriggerEvent, context: Context) => {
  const { email } = event.request.userAttributes;
  if (email) {
    const domain = email.split('@')[1];
    // 認証しない場合は空のオブジェクトを返してinvalid-lambda-responseとする
    context.done(undefined, domain === 'mydomain.jp' ? event : null);
  }
};
```

cognito側に認証可否を伝達するために `context.done(undefined, event)` を呼ぶ必要がある

- [AWS Developer Forums: Pre authorization Trigger: "Invalid ...](https://forums.aws.amazon.com/thread.jspa?threadID=237677)


### eventオブジェクト

lambda関数に渡される `[event, context]` はこんな感じ

```json
[
  {
    "version": "1",
    "region": "ap-northeast-1",
    "userPoolId": "ap-northeast-1_asdfjhf9m",
    "userName": "Google_103571795941234567890",
    "callerContext": {
      "awsSdkVersion": "aws-sdk-unknown-unknown",
      "clientId": "123456789i9mrulbr36pasdfa5"
    },
    "triggerSource": "PreSignUp_ExternalProvider",
    "request": {
      "userAttributes": {
        "cognito:email_alias": "",
        "cognito:phone_number_alias": "",
        "email": "forspammymail@gmail.com"
      },
      "validationData": {}
    },
    "response": {
      "autoConfirmUser": false,
      "autoVerifyEmail": false,
      "autoVerifyPhone": false
    }
  },
  {
    "callbackWaitsForEmptyEventLoop": true,
    "logGroupName": "/aws/lambda/SignUpValidation",
    "logStreamName": "2019/03/23/[$LATEST]",
    "functionName": "SignUpValidation",
    "memoryLimitInMB": "128",
    "functionVersion": "$LATEST"
  }
]

```
