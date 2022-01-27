---
title: "nodejs の `google-spreadsheet` を使ってスプレッドシートを更新する"
slug: nodejs-modify-google-spreadsheet
date: 2022-01-27T17:44:58+09:00
draft: false
author: sakamossan
---

SpreadSheetとGCPの認証認可については、以前にこちらに書いた。

- [サービスアカウントで認証してGoogleSpreadsheetからデータを取得](https://blog.n-t.jp/tech/spreadsheet-via-service-account/)

今回は nodejs の `google-spreadsheet` を使ってシートを更新する

- [theoephraim/node-google-spreadsheet: Google Sheets API (v4) wrapper for Node.js](https://github.com/theoephraim/node-google-spreadsheet)


## 実装例

`string[][]` を使って、対象のシートをその内容で上書きするという実装。


```ts
import { GoogleSpreadsheet } from "google-spreadsheet";
import cred from "./cred.json";
export const SHEET_ID = "xxxxxxxxxx";

export class Doc {
  constructor(private doc: GoogleSpreadsheet) {}

  static async from(sheetId: string) {
    const doc = new GoogleSpreadsheet(sheetId);
    const { client_email, private_key } = cred;
    await doc.useServiceAccountAuth({ client_email, private_key });
    await doc.loadInfo();
    return new Doc(doc);
  }

  async updateAsRenewSheet<Row = any>(sheetTitle: string, header: string[], body: Row[]) {
    if (!header.length || !body?.length) {
      throw Error(`It seems to passed empty header or empty body`);
    }
    let sheet = this.doc.sheetsByTitle[sheetTitle];
    if (sheet == null) {
      await this.doc.addSheet({ title: sheetTitle });
      sheet = this.doc.sheetsByTitle[sheetTitle];
    } else {
      await sheet.clear();
    }
    await sheet.setHeaderRow(header as any);
    await sheet.addRows(body as any);
  }
}
```

## 参考

他にも色々シートを操作するメソッドが実装されている。

- [GoogleSpreadsheetWorksheet](https://theoephraim.github.io/node-google-spreadsheet/#/classes/google-spreadsheet-worksheet)
