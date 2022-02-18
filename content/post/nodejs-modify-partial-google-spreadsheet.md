---
title: "nodejs の `google-spreadsheet` でシートの一部を更新する"
slug: nodejs-modify-partial-google-spreadsheet
date: 2022-02-18T18:50:43+09:00
draft: false
author: sakamossan
---

こちらの続き。

- [nodejs の `google-spreadsheet` を使ってスプレッドシートを更新する](https://blog.n-t.jp/tech/nodejs-modify-google-spreadsheet/)

件のやりかたではシートを消してから新しいデータを入れていたが、シートの一部だけを更新したい場合があったので、そのあたりをケアした実装をした。

```ts
  async updateColnameSheet<Row = any>(sheetTitle: string, header: string[], body: Row[]) {
    const doc = new GoogleSpreadsheet(...)
    await doc.useServiceAccountAuth({...});
      
    let sheet = doc.sheetsByTitle[sheetTitle];
    if (sheet == null) {
      await doc.addSheet({ title: sheetTitle });
      sheet = doc.sheetsByTitle[sheetTitle];
    } else {
      await sheet.loadCells()
      const rows = await sheet.getRows();
      for (let i = 1; i < rows.length; i++) {
        for (let j = 0; j < header.length; j++) {
          const cell = sheet.getCell(i, j);
          cell.value = "";
        }
      }
      await sheet.saveUpdatedCells();
    }
    await sheet.setHeaderRow(header as any);
    await sheet.addRows(body as any);
  }
```

## 肝心部分

やりたかったのは「A,Bカラムだけ消したい」というものだが、SheetAPIでは「カラムのデータをすべて消す」という指示ができないので、いま入っているデータを空文字で消し込む必要があった。

```ts
      const rows = await sheet.getRows();
      for (let i = 1; i < rows.length; i++) {
        for (let j = 0; j < header.length; j++) {
          const cell = sheet.getCell(i, j);
          cell.value = "";
        }
      }
      await sheet.saveUpdatedCells();
```
