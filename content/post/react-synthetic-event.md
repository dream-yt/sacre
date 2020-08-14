---
title: "React の Synthetic Event"
date: 2019-07-01T09:34:06+09:00
draft: false
author: sakamossan
---

Reactに標準でついてくるEventオブジェクト
Syntheticは合成という意味

ブラウザごとの差異を吸収してくれている

- [SyntheticEvent – React](https://reactjs.org/docs/events.html)


## event pooling

なお、Reactにはevent poolingという仕組みがある
シングルトンのSynthetic Eventをアプリ内で使いまわしている

なので、onClickなどのイベントハンドラの関数内でしか
イベントオブジェクトへアクセスできないことになっている

たとえば以下のように、非同期でEventを触るコードはエラーになる


```js
function clickHandler(event) {
  this.setState({ foo: 'bar' }, () => {
    console.log(event.target.value); // error
  });
}
```
