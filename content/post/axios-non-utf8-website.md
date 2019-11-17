---
title: "UTF-8じゃないサイトをaxiosで取得する"
date: 2019-11-17T12:34:41+09:00
draft: false
---

axiosはデフォルトでサイトの文字コードをUTF-8決め打ちでデコードしてしまう  
なのでUTF-8じゃないサイトを取得すると文字化けする

- [how to decode non-utf8 response? · Issue #332 · axios/axios](https://github.com/axios/axios/issues/332)

以下のやり方でUTF-8以外のデコードができるようだ

- `responseType` に `arraybuffer` を指定する
- `transformResponse` で `response.data` を期待する文字コードにデコードする

自動でエンコーディングを判定してくれるchardetを使うとこんな感じになる

```ts
import * as chardet from 'chardet';
import * as iconv from 'iconv-lite';

axios.create({
  responseType: 'arraybuffer',
  transformResponse: data => {
    const encoding = chardet.detect(data);
    if (!encoding) {
      throw new Error('chardet failed to detect encoding');
    }
    return iconv.decode(data, encoding);
  }
})
```


## 参考

chardetの仕組みについて

- [A composite approach to language/encoding detection](https://www-archive.mozilla.org/projects/intl/universalcharsetdetection)

UTF-8じゃないサイトを探す時に役に立った

- [上場企業HP文字コード一覧(2017/10/20) - Google スプレッドシート](https://docs.google.com/spreadsheets/d/1Z_rR1UvpQnvf75DPBLP7LByXSIavT-mBdBmFegbeB4w/edit#gid=972298121)
