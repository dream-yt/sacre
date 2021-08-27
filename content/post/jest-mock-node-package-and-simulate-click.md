---
title: "jest でパッケージをモックしながら react-test-utils でクリックイベントをテストする"
slug: jest-mock-node-package-and-simulate-click
date: 2021-08-27T17:22:46+09:00
draft: false
author: sakamossan
---

こんな実装になった。

```ts
import React from "react";
import ReactDOM from "react-dom";
import { act, Simulate } from "react-dom/test-utils";
import { Button } from "./Button";

const fn = jest.fn();
jest.mock("mocked-packagejs", () => (...args: any) => {
  fn(...args);
});

test("basic", async () => {
  const container = document.createElement("div");
  document.body.appendChild(container);
  act(() => ReactDOM.render(<Button />, container));
  const button = container.querySelector("button")!;
  await act(async () => Simulate.click(button));
  const args = fn.mock.calls[0];
  expect(!args).toBe(true);
});
```


## jest.mock

jest.mock は import などと同じ scope に置かなくてはならない。

```ts
jest.mock("mocked-packagejs", () => (...args: any) => {
  fn(...args);
});
```

> Note: In order to mock properly, Jest needs jest.mock('moduleName') to be in the same scope as the require/import statement.

- [Manual Mocks · Jest](https://jestjs.io/docs/manual-mocks#mocking-user-modules)

この制約があって `mocked-packagejs` が返す値をテストにて変更しながらテストを回すことができなかった。やろうとするとなんらかのオブジェクトにラップして `mockFn.mockReturnValue` とかでやる必要があるのだろう。


## Simulate.click

Clickイベントなので当然のことながら処理が非同期になる。
await してあげないと処理がタスクキューにのってるうちにテストのassertが呼ばれてしまう。

ただし、単純に await をつけるだけだと以下の warn がでる。

>  Warning: Do not await the result of calling act(...) with sync logic, it is not a Promise.

なので async もつけておく。

```ts
await act(async () => Simulate.click(button));
```
