---
title: "TypeScriptで外部スクリプトからロードされたグローバル変数のエラーを無視する"
date: 2020-08-17T18:11:09+09:00
draft: false
author: sakamossan
---

GoogleChartはnpmパッケージになっておらず、またローカルにファイルを置くことが許可されていない

> Sorry; our terms of service do not allow you to download and save or host the google.charts.load or google.visualization code. However, if you don't need the interactivity of Google Charts, you can screenshot the charts and use them as you wish.

- [Copy as Markdown - Chrome ウェブストア](https://chrome.google.com/webstore/detail/copy-as-markdown/fkeaekngjflipcockcnpobkpbbfbhmdn?hl=ja)

なのでこのように外部jsファイルとして読み込むことになっている

```html
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> 
```

これはTypeScriptでは知らないグローバル変数として怒られる

> Cannot find name 'google'.ts(2304)

このエラーは以下の宣言で無視することができる

```ts
declare var google;
```

## 宿題

型定義もあるようなので、型定義をつかって解決する方がよい

- [typescript - How can I use google.visualization typings with Angular CLI? - Stack Overflow](https://stackoverflow.com/questions/54738588/how-can-i-use-google-visualization-typings-with-angular-cli)
- [TypeScript: Handbook - tsconfig.json](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html#types-typeroots-and-types)
