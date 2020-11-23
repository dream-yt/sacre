---
title: "React.SuspenseとsetTimeoutで最小限の非同期コンポーネントをつくる"
slug: react-suspense-settimeout-minimum
date: 2020-11-05T15:07:42+09:00
draft: false
author: sakamossan
---

こんなコードで1秒後に `helloworld` と表示できるコンポーネントが作れる

```ts
// 「1秒以内はPromiseがthrowされて、1秒後にはundefinedが返ってくる関数」を返す関数
const delay = () => {
  let isTimeout = false;
  // 1秒後にisTimeoutがTrueになる
  const promise = new Promise(resolve => setTimeout(() => resolve(), 1000));
  promise.then(() => (isTimeout = true));

  return () => {
    if (isTimeout) {
      return;
    } else {
      // 1秒まではいつ呼んでもPromiseがthrowされる
      // Promiseがthrowされる限りSuspenseはfallbackを表示する
      throw promise;
    }
  };
};
let f;
const Trigger = () => {
  // このあと何回Trigger関数が呼ばれても1秒間はPromiseがthrowされる
  f = f || delay();
  f();
  // 1秒後からTrigger関数は正常に終了して普通のコンポーネントが返ってくるようになる
  return <p>hello world</p>;
};
const DelayedComp = () => {
  return (
    // throwされたPromiseはReact.Suspenseがcatchしてfallbackを表示してくれる
    <React.Suspense fallback={<p>loading...</p>}>
      <Trigger />
    </React.Suspense>
  );
};
ReactDOMServer.renderToString(<DelayedComp />);
```

## 参考

- [ReactのSuspenseで非同期処理を乗りこなす](https://sbfl.net/blog/2020/02/10/react-suspense-async/)
- [サスペンスを使ったデータ取得（実験的機能） – React](https://ja.reactjs.org/docs/concurrent-mode-suspense.html)
