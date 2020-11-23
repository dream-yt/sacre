---
title: "nextjs で 404 を返す方法"
slug: nextjs-ssr-404
date: 2020-11-21T08:49:54+09:00
draft: false
author: sakamossan
---

nextjs の SSR で 404 を返すには、`getServerSideProps` でこうする

```ts
const getServerSideProps: GetServerSideProps = async (context) => {
  context.res.statusCode = 404;
  return { props: { errorCode: 404 } };
};
```

あとはコンポーネント側でよしなに 404 ページをレンダリングすればよい

とりあえず動かす段階なら next ビルトインの Error ページを使ってもいいだろう

- [reusing-the-built-in-error-page](https://nextjs.org/docs/advanced-features/custom-error-page#reusing-the-built-in-error-page)

## 参考

- [Advanced Features: Custom Error Page | Next.js](https://nextjs.org/docs/advanced-features/custom-error-page)
- [How to return a 404 error in getServerSideProps with Next.js - Ironeko](https://ironeko.com/posts/how-to-return-a-404-error-in-getserversideprops-with-next-js?ref=last_articles)
