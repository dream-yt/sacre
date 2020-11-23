---
title: "html5のFileオブジェクトからimg/videoタグで使えるURLを取得する"
slug: html5-read-file-data-ad-url
date: 2020-11-04T15:27:45+09:00
draft: false
author: sakamossan
---

こんな関数で取得できる

```ts
const f = (file: File) => {
  const reader = new FileReader();
  const promise = new Promise((resolve, reject) => {
    reader.onerror = e => reject(e);
    reader.onabort = e => reject(e);
    reader.onload = e => resolve(e.target?.result);
  });
  reader.readAsDataURL(file);
  return promise;
};

...

const url = f(event.currentTarget.files[0]);
return <video><source src={url} /></video>
```

## 参考

- [Web アプリケーションからのファイルの使用 - Web API | MDN](https://developer.mozilla.org/ja/docs/Web/API/File/Using_files_from_web_applications)
- [<video>: 動画埋め込み要素 - HTML: HyperText Markup Language | MDN](https://developer.mozilla.org/ja/docs/Web/HTML/Element/video)
- [FileReader - Web API | MDN](https://developer.mozilla.org/ja/docs/Web/API/FileReader)