---
title: "React Testing Library で a test was not wrapped in act をなんとかする"
slug: a-test-was-not-wrapped-in-act
date: 2021-04-28T17:34:51+09:00
draft: false
author: sakamossan
---

Formik を使っていてこんな警告が出た。

> console.error node_modules/react-dom/cjs/react-dom.development.js:530
>  Warning: An update to Formik inside a test was not wrapped in act(...).
>  When testing, code that causes React state updates should be wrapped into act(...):

コンポーネントの更新をともなうテストは act 関数のコールバック内で行うことになっているそうだ。もし、それ以外の場所でコンポーネントが更新されたとき、React は予期せぬ更新だとして上述の警告を出す。

act 関数を使うのでもいいが、React Testing Library は waitFor という関数を提供しているので、その中でアサーションをするのであれば警告を免れることができる。また、waitFor は単純に便利なのでこれを使うと具合がいい。

> When in need to wait for any period of time you can use waitFor, to wait for your expectations to pass. Here's a simple example:

- [Async Methods | Testing Library](https://testing-library.com/docs/dom-testing-library/api-async/#waitfor)

### 例

```tsx
  test("submit call refreshWithQueryparameter", async () => {
    const { getByText } = rendered;
    // locationオブジェクトをいじるイベントをキック
    fireEvent.click(getByText('Submit'))
    await waitFor(() => {
      expect(global.location.search).toBe("OK=1");
    });
  });
```

## 参考

- [テストユーティリティ – React](https://ja.reactjs.org/docs/test-utils.html#act)
- [Fix the "not wrapped in act(...)" warning](https://kentcdodds.com/blog/fix-the-not-wrapped-in-act-warning)
