---
title: "環境変数にセットしてあるGoogleのJWTを使って認証する"
date: 2018-12-04T10:05:39+09:00
draft: false
---

GoogleのAPIを叩く際に、`GOOGLE_APPLICATION_CREDENTIALS`を使ってファイルから認証情報を読み取る例は書いてあったが、lambdaなどで環境変数に入ってる認証情報を使う方法が見つからなかったのでメモ

こちらに書いてある`fromJSON` を使う方法を試したら通った

- [google-auth-library-nodejs#Loading credentials from environment variables](https://github.com/googleapis/google-auth-library-nodejs#loading-credentials-from-environment-variables)

> Instead of loading credentials from a key file, you can also provide them using an environment variable and the GoogleAuth.fromJSON() method. This is particularly convenient for systems that deploy directly from source control (Heroku, App Engine, etc).

```js
const { google } = require('googleapis');
const sheets = google.sheets('v4');

async function getSpreadsheetData (spreadsheetId: string, range: string) {
    // `CREDJSON` 環境変数にJWTが入ってるとして
    const cred = JSON.parse(process.env.CREDJSON);
    const auth = google.auth.fromJSON(cred);
    auth.scopes = ['https://www.googleapis.com/auth/spreadsheets'];

    return new Promise((resolve, reject) => {
        this.spreadsheetValue.get(
            { auth, spreadsheetId, range }
            (err, resp) => (err ? reject(err) : resolve(resp.data.values)),
        );
    });
}
```

### `googleapis` と `google-auth-library`

以下のオブジェクトは同じ実装なんだろうか 🤔

- `require('googleapis').google.auth`
    - [googleapis/google-api-nodejs-client: Google's officially supported Node.js client](https://github.com/googleapis/google-api-nodejs-client)
- `require('google-auth-library')`
    - [googleapis/google-auth-library-nodejs: 🔑 Google Auth Library for Node.js](https://github.com/googleapis/google-auth-library-nodejs)
