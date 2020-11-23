---
title: "ページ内の全ての日本語を○△□に置き換える"
slug: replace-all-japanese-in-page
date: 2020-09-05T12:07:03+09:00
draft: false
author: sakamossan
---

nodejs/express で開発をしていて、画面内の日本語をすべて記号に置き換えたい時があったのでこのようにした

```js
const replace = require('stream-replace');
stream = stream
    .pipe(replace(/[ぁ-ん]/g, '○'))
    .pipe(replace(/[ァ-ヶ]/g, '△'))
    .pipe(replace(/[一-龠]/g, '□'))
stream.pipe(response);
```

こんな見た目になるので、ある程度はなにがなんだかわからなくなる

![](https://raw.githubusercontent.com/sakamossan/image-bed/master/assets/ba731a1b-fd99-67e7-c2df-114ee42acb47.png)


## 参考

- [JavaScriptで漢字を表す正規表現 | You Look Too Cool](https://stabucky.com/wp/archives/7594)
- [lxe/stream-replace: Replace text in a stream](https://github.com/lxe/stream-replace)