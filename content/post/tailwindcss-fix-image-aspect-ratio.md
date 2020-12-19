---
title: "tailwindcssで画像のアス比を固定する"
slug: tailwindcss-fix-image-aspect-ratio
date: 2020-12-19T16:54:10+09:00
draft: false
author: sakamossan
---

`object-contain` を使えばよい。

```jsx
<img class="object-contain" src="/image.jpg" />
```

## どうなっているのか

css の `object-fit: contain` を使っている。

> 置換コンテンツはアスペクト比を維持したまま、要素のコンテンツボックスに収まるように拡大縮小されます。オブジェクト全体がボックス内に表示され、アスペクト比が維持されるので、オブジェクトのアスペクト比とボックスのアスペクト比が合わない場合は、レターボックス表示になります。

- [object-fit - CSS: カスケーディングスタイルシート | MDN](https://developer.mozilla.org/ja/docs/Web/CSS/object-fit)

`object-fit` 知らなかった。昔は画像のアスペクト比を固定するためにiframeを使ったり四苦八苦していたこともあったようだが便利な世の中に生まれてよかった。

## 参考

- [How to preserve Aspect Ratio of Images with Tailwind CSS — swjh.io](https://www.swjh.io/blog/preserve-aspect-ratio-of-images-with-tailwind-css/)

