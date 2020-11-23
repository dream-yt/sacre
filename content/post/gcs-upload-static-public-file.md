---
title: "nodejsで Google Cloud Storage にファイルをアップロードしてCDNで配信する"
slug: gcs-upload-static-public-file
date: 2019-12-04T14:47:44+09:00
draft: false
author: sakamossan
---

こんな場合のスニペット

- データをJSON形式でアップロードしたい
- 静的ファイルをアップロードしてCDNがわりに使うようなヘッダを付与したい
  - gcsはs3と違い、公開バケットをCDNキャッシュされてるような状態で配信できる

```ts
const upload = async (data, gcsUrl) => {
  const storage = new Storage({
    projectId: '...',
    // gcpのコンソールからダウンロードできるjson鍵ファイル
    credentials: require('cred.json')
  });
  // gs://bucket-name/key/of/path みたいな文字列をパース
  const [bucketName, ...keys] = gcsUrl.replace('gs://', '').split('/');

  // fileオブジェクトを作ってそこにデータを流し込む
  const file = storage
    .bucket(bucketName)
    .file(keys.join('/'));

  // `gzip: true` でアップロードすると gz圧縮された状態でアップロードされる
  // クライアントが Accept-Encoding ヘッダを送ってくる場合には Content-Encoding: gzip で返される
  await file.save(JSON.stringify(data), { gzip: true });
  
  // もろもろメタデータが設定できる
  await file.setMetadata({
    contentType: 'application/json',
    cacheControl: 'public, max-age=600',
    contentLanguage: 'ja'
  });
};
```

`file#metadata` はドキュメントにもほとんど記載がなく、TypeScriptの型定義ファイルでも`any`になっているのでどんな引数をとるのかがよくわからなかったが、公式のexampleにいろいろ書いてある

ここの another example あたり

- [File - Documentation](https://googleapis.dev/nodejs/storage/latest/File.html#getMetadata-examples)

>  console.log(`Cache-control: ${metadata.cacheControl}`);
>  console.log(`Content-type: ${metadata.contentType}`);
>  console.log(`Content-disposition: ${metadata.contentDisposition}`);
>  console.log(`Content-encoding: ${metadata.contentEncoding}`);
>  console.log(`Content-language: ${metadata.contentLanguage}`);
