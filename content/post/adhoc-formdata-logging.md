---
title: "htmlで、雑にformから送信される値を見たい"
slug: adhoc-formdata-logging
date: 2019-02-26T12:47:49+09:00
draft: false
author: sakamossan
---

- submitイベントを途中で止める
- FormDataクラスをつかう

こんなコードを仕込めば値が一覧できる

```js
const form = document.querySelector('form');
form.addEventListener('submit', (event) => {
    const formData = new FormData(form);
    for (let i of formData.entries()) {
        console.log(i.join("\t"));
    }
    console.log('---');
    event.preventDefault();
});
```


## 参考

- [FormData オブジェクトの利用 - ウェブデベロッパーガイド | MDN](https://developer.mozilla.org/ja/docs/Web/Guide/Using_FormData_Objects)
- [Event.preventDefault() - Web API | MDN](https://developer.mozilla.org/ja/docs/Web/API/Event/preventDefault)
