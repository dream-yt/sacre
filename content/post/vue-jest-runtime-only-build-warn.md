---
title: "runtime-only build of Vue where the template compiler is not available"
date: 2020-04-14T12:15:24+09:00
draft: false
author: sakamossan
---

vueコンポーネントが混ざったjsのテストで以下のようなwarningがでる

> [Vue warn]: You are using the runtime-only build of Vue where the template compiler is not available. Either pre-compile the templates into render functions, or use the compiler-included build

これは、単一ファイルコンポーネントではないVueコンポーネント( `runtime-only build` )をランタイムでコンパイルなしに使おうとしていて咎められているようだ

templateをコンパイル済みのjsコードを用意するか、`compiler-included build` のvueを使うかが逃げ道として提示されている

`compiler-included build` のvueを使うほうが楽そうだ。jestでテストを走らせているので、そのランタイムで`compiler-included build` のvueが使われるようにする

具体的には jest.config.js にて moduleNameMapper に以下の設定を入れる

```js
// commonjsのプロジェクトなので `vue.common.dev.js`
moduleNameMapper = {'^vue$': 'vue/dist/vue.common.dev.js'}
```

## 参考

- [[Vue warn]: You are using the runtime-only build of Vue where the template compiler is not available. Either pre-compile the templates into render functions, or use the compiler-included build. · Issue #2754 · vuejs/vue-cli](https://github.com/vuejs/vue-cli/issues/2754)
- [jestjs - Running Jest tests in Vue.js - Stack Overflow](https://stackoverflow.com/questions/43154381/running-jest-tests-in-vue-js)



