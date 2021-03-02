---
title: "CSVダウンロードのときにつけるヘッダ"
slug: browser-download-http-header
date: 2021-03-02T12:11:23+09:00
draft: false
author: sakamossan
---

```
Content-Type: text/csv; charset=cp932
Content-Disposition: attachment;filename=your_filename.csv
```

- CSVファイルはエクセルで開かれることが多いのでエンコーディングはcp932を使う
- ダウンロードファイルなことを明示するために `Content-Disposition` を明示する
- `Content-Transfer-Encoding` というヘッダを設定する例がでてくるけど、これは電子メール用のヘッダなのでつけてもブラウザはこれを無視する。つけないでよい

## 参考

- [Shift_JIS と Windows-31J (MS932) の違いを整理してみよう |](https://weblabo.oscasierra.net/shift_jis-windows31j/)
- [Content-Disposition - HTTP | MDN](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Content-Disposition)
- [base64 - Is Content-Transfer-Encoding an HTTP header? - Stack Overflow](https://stackoverflow.com/questions/7285372/is-content-transfer-encoding-an-http-header)
  - [HTTP/1.1: Header Field Definitions](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html)
