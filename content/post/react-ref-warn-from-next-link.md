---
title: "Next の Link コンポーネントで Warning: Function components cannot be given refs"
slug: react-ref-warn-from-next-link
date: 2021-02-27T11:43:02+09:00
draft: false
author: sakamossan
---

`next/link` の `Link` コンポーネントは、children に関数コンポーネントを入れると警告が出る

```jsx
import Link from "next/link";

<Link href="/">
  <MyButton />
</Link>;
```

> Warning: Function components cannot be given refs. Attempts to access this ref will fail. Did you mean to use React.forwardRef()?

Link は子要素に ref を渡す実装になっているので、関数コンポーネントに ref を渡してしまって警告が出ている。

- https://github.com/vercel/next.js/blob/55e4a3d1add44aede18f4bc9f604f59ba49cc0b0/packages/next/client/link.tsx#L279

これは仕様ということになっているが、サクッと修正できる方法が存在しない、バグのような挙動だと言われている。

- [Next 9 - Using functional components as child of <Link/> causes ref-warnings · Issue #7915 · vercel/next.js](https://github.com/vercel/next.js/issues/7915)

修正する方法の 1 つはメッセージ通りに `React.forwardRef` を使う方法。

```jsx
const CustomComponent = React.forwardRef(function CustomComponent(props, ref) {
  return <div />;
});
```

とりあえず警告をでないようにしたいなら一番手軽なのは Fragment で囲ってしまうという方法がある、ただしこれだと Link が子要素に Click イベントが渡せなくなってしまうのでそういう子要素のときは使えない。

```jsx
<Link href="/">
  <>
    <MyButton />
  </>
</Link>
```

- https://github.com/vercel/next.js/issues/7915#issuecomment-514864334

## 参考

- [next/link | Next.js](https://nextjs.org/docs/api-reference/next/link#if-the-child-is-a-custom-component-that-wraps-an-a-tag)
