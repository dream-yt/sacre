---
title: "flexで横並びカードのレイアウト最小限"
slug: css-flex-horizontal-card
date: 2020-09-16T09:22:10+09:00
draft: false
author: sakamossan
---

画像が左、説明文が右というレイアウトの最小限の定義

<iframe src="https://codepen.io/gsxuomug/embed/preview/ZEWjvBq?height=300&amp;slug-hash=ZEWjvBq&amp;default-tabs=html%2Cresult&amp;host=https%3A%2F%2Fcodepen.io" style="border: 0; width: 100%; height: 300px;" allowfullscreen></iframe>

```html
<div class="card">
  <div class="card-left">
    <img src="https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/1989/19892000.jpg?_ex=200x200" />
  </div>
  <div class="card-right">
    <h3>{book.title}</h3>
    <p>{book.itemCaption}</p>
  </div>
</div>
```

```css
.card {
  display: flex;
  /* PCで閲覧された時に横幅を絞っておく */
  width: 600px;
}

.card-left {
  width: 30%;
}
.card-left img {
  /* この定義をしないと画像がはみ出る */
  width: 100%;
}

.card-right {
  width: 70%;
}
```
