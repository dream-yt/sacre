---
title: "既存のtypescriptプロジェクトにnextjsのSSGを導入する"
date: 2020-09-06T15:43:45+09:00
draft: false
author: sakamossan
--- 

簡単に追加できる。


## 準備

nextを入れる

```bash
$ npm install next
```

src/pages配下にtsxを作成

```bash
$ touch ./src/pages/index.tsx
```

なお、nextはトップレベルではなくsrc配下にpagesディレクトリを作ってもちゃんとそこを認識してくれるようだ。

> Pages can also be added under src/pages as an alternative to the root pages directory.
> The src directory is very common in many apps and Next.js supports it by default.

- [Advanced Features: `src` Directory | Next.js](https://nextjs.org/docs/advanced-features/src-directory)


## index.tsx

index.tsxはこんな感じ

```jsx
import { GetStaticProps } from "next";
import React from "react";

export default ({ hello }: { hello: string }) => <h1>{hello}</h1>;

// 
export const getStaticProps: GetStaticProps = async () => {
  const hello = "helloworld";
  return { props: { hello } };
};
```

- `getStaticProps`
    - `next export` の時に呼ばれて、結果がdefault関数にpropsとして渡される
- default関数
    - このページのhtmlを生成するコンポーネント


## 動作確認

```console
$ npx next build && npx next export && npx next start &

...

$ ready - started server on http://localhost:3000
$ curl http://localhost:3000
<!DOCTYPE html><html><head><meta charSet="utf-8"/><meta name="viewport" content="width=device-width"/><meta name="next-head-count" content="2"/><noscript data-n-css="true"></noscript><link rel="preload" href="/_next/static/chunks/main-087f27b04f4c732ab1a1.js" as="script"/><link rel="preload" href="/_next/static/chunks/webpack-e067438c4cf4ef2ef178.js" as="script"/><link rel="preload" href="/_next/static/chunks/framework.cb05d56be993eb6b088a.js" as="script"/><link rel="preload" href="/_next/static/chunks/f6078781a05fe1bcb0902d23dbbb2662c8d200b3.00aaea69a4bfc61676f6.js" as="script"/><link rel="preload" href="/_next/static/chunks/pages/_app-af1b8e54567fd58d71e4.js" as="script"/><link rel="preload" href="/_next/static/chunks/pages/index-cc4f0e2bbac07be32208.js" as="script"/></head><body><div id="__next"><h1>helloworld</h1>

...
```

## その他

typescript環境で動かすとnextが勝手にtsconfig.jsonを変更する。

```diff
+    "allowJs": true,
+    "skipLibCheck": true,
+    "forceConsistentCasingInFileNames": true,
+    "noEmit": true,
+    "isolatedModules": true
```

また、`next-env.d.ts` というファイルがトップレベルに作成される。

```diff
/next-env.d.ts
@@ -0,0 +1,2 @@
+/// <reference types="next" />
+/// <reference types="next/types/global" />
```

デフォルトだと以下にビルド結果のファイルが作られるので .gitignore に追加しておく。

```diff
+# next
+/out
+/.next
```