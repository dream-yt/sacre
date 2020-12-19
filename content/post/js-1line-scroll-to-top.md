---
title: "js 1 行でページ上部までスクロールする"
slug: js-1line-scroll-to-top
date: 2020-12-10T17:10:46+09:00
draft: false
author: sakamossan
---

こうするとできる。

```js
document.getElementsByTagName("body")[0].scrollIntoView({ behavior: "smooth" });
```

## 説明

モダンなブラウザでは `scrollIntoView` が使える。

- [Element.scrollIntoView() - Web API | MDN](https://developer.mozilla.org/ja/docs/Web/API/Element/scrollIntoView)

`behavior: "smooth"` と指定するとスルスルとアニメーションしながら上にスクロールするが、`behavior: "auto"` と指定するとパッと一瞬で上に飛ぶ。

一瞬で飛んでしまうと、ユーザーは別なページに飛んだように感じることがあるため、なるべくアニメーションでスクロールさせたほうがよい。なお Safari は `behavior=smooth` オプションを実装していないのでページ上部に飛ぶ挙動になる。
