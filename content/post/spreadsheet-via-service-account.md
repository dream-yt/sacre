---
title: "サービスアカウントで認証してGoogleSpreadsheetからデータを取得"
slug: spreadsheet-via-service-account
date: 2018-12-01T16:30:16+09:00
draft: false
author: sakamossan
---

spreadsheetのデータを取ってくるやり方をググったらいいのが見つからなかった

- 認証周りをガバガバでやってそう
- 古い認証方式(oauth)の紹介になってそう

spreadsheetはpublicにしてcsvで取得するのが一番楽だが、
もっと権限をちゃんとしないといけない場合のフローをメモしておく

- gcpのプロジェクトがある前提からスタート
- そこにサービスアカウントを作る
- サービスアカウントがspreadsheetにアクセスできるようにする


### APIライブラリのページでSheetsAPIを有効化

- https://console.developers.google.com/apis/api/sheets.googleapis.com/overview?project=
- https://console.developers.google.com/apis/library/drive.googleapis.com

![image](https://user-images.githubusercontent.com/5309672/49325337-08fbad80-f584-11e8-8c55-739cd1b75b28.png)


### APIとサービス/認証情報のページへ

- https://console.developers.google.com/apis/credentials

![image](https://user-images.githubusercontent.com/5309672/49324955-d39f9180-f57c-11e8-878f-832c5924299a.png)


#### サービスアカウントを作成

`Select a role` は空でつくってよい (通知出るけどwithoutでよい)

![image](https://user-images.githubusercontent.com/5309672/49325434-a60b1600-f585-11e8-94ed-bc57ab9f85ef.png)


### サービスアカウントにスプレッドシートの権限を入れる

右上の`共有`ボタンから

- https://console.developers.google.com/iam-admin/serviceaccounts

![image](https://user-images.githubusercontent.com/5309672/49325424-7cea8580-f585-11e8-8a0f-67eb5b3f9a9f.png)


#### sheetId とは

- こんなURLの場合は
    - https://docs.google.com/spreadsheets/d/1HucDy33jZYDSGmXvIGDL5SOu4mv9B2mJui3Bi512345/edit#gid=0
- この部分
    - `1HucDy33jZYDSGmXvIGDL5SOu4mv9B2mJui3Bi512345`


### 叩いてみる

- [こちら](https://qiita.com/howdy39/items/22068b3f768f0f9a757d)のコピペ

`yarn add googleapis` などしてから以下のコードでoneシートの右上4マスが取ってこれる

```js
const { google } = require('googleapis');
const sheets = google.sheets('v4');
const path = require('path');

execAPI('1HucDy33jZYDSGmXvIGDL5SOu4mv9B2mJui3Bi512345', 'one!A1:B2');

async function execAPI(spreadsheetId, range) {
  const auth = await google.auth.getClient({
    keyFile: path.join('/Users/jibun/Documents/jibunno-612344e1408a.json'),
    scopes: ['https://www.googleapis.com/auth/spreadsheets'],
  });

  const apiOptions = {
    auth,
    spreadsheetId,
    range,
  };

  sheets.spreadsheets.values.get(apiOptions, (err, res) => {
    console.log(err);
    console.log(res.data.values);
  });
}
```


### 参考

サービスアカウントとG-Suiteの権限についてはこちらが分かりやすかった

- [スプレッドシートをWebAPI化するサービスの作り方 - Qiita](https://qiita.com/howdy39/items/22068b3f768f0f9a757d)
