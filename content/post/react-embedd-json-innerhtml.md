---
title: "reactでhtml内にjsonを埋め込む"
date: 2019-10-22T20:53:11+09:00
draft: false
---

- reactのVDOMにJSONを埋め込もうとすると、htmlサニタイズされてしまう
- サニタイズされた文字列を読み込むのは面倒
- サニタイズされないように文字列を埋め込むのには `dangerouslySetInnerHTML` を使う


```jsx
<template id="foo" dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }} />
```

埋め込んだ値を使うときはこんな感じ (innerHTML に入る)

```js
const template = document.getElementById('foo');
const data = JSON.parse(template.innerHTML)
```


### 参考

- [DOM Elements – React # dangerouslySetInnerHTML](https://reactjs.org/docs/dom-elements.html#　dangerouslysetinnerhtml)
