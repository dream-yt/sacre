---
title: "[jest] SyntaxError: The string did not match the expected pattern"
date: 2020-06-07T06:46:32+09:00
draft: false
author: sakamossan
---

axios を使った jest のテストで以下のようなエラーが出た

> SyntaxError: The string did not match the expected pattern.

これは jest ランタイムだと axios が XMLHttpRequest を使おうとしてしまうため発生するエラーだったようだ

jest.config.js に `testEnvironment: 'node'` を追加すればよい

```js
module.exports = {
  verbose: true,
  testEnvironment: 'node',
  ...
```

## 参考

- [detect jest and use http adapter instead of XMLhttpRequest · Issue #1180 · axios/axios](https://github.com/axios/axios/issues/1180)
- [Unmocking axios? I get 'the string did not match the expected pattern' · Issue #5737 · facebook/jest](https://github.com/facebook/jest/issues/5737)
