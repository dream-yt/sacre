---
title: "複数属性をもつ要素を指定するCSSセレクタ"
date: 2020-04-27T10:23:34+09:00
draft: false
author: sakamossan
---

たとえばこんな要素に複数の属性でマッチさせたい場合

```html
<input type="file" multiple />
```

こんな指定になる

```css
input[type="file"][multiple] { 
  ...
}
```


### 参考

- [Specify multiple attribute selectors in CSS - Stack Overflow](https://stackoverflow.com/questions/12340737/specify-multiple-attribute-selectors-in-css)
