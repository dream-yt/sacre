---
title: "Bootstrap に detail/summary タグの「▶︎」が消されてしまう時の対応"
slug: revive-bootstrap-suppressed-summary-tag-triangle
date: 2021-10-29T12:14:48+09:00
draft: false
author: sakamossan
---

Bootstrapのバージョンが上げられていないと発生する事象。
Bootstrapの reset.css が悪さをしていて、detail/summary タグの「▶︎」の部分が表示されなくなってしまう。


## 対応

Bootstrapのアップグレードができない場合は、CSSを上書きするとなんとかなる。

```css
summary {
    display: list-item;
}
```

## 参考

- [Expand arrow gone from summary element · Issue #21060 · twbs/bootstrap](https://github.com/twbs/bootstrap/issues/21060)
