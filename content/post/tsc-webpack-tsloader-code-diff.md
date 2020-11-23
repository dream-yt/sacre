---
title: "webpack+ts-loaderとtscで同じコードをトランスパイルした結果の違いをみてみる"
slug: tsc-webpack-tsloader-code-diff
date: 2020-08-29T17:19:29+09:00
draft: false
author: sakamossan
---

トランスパイルされる元のコードはこんな感じ

#### index.ts

```ts
import { f } from './A';
console.log("this is index");
f();
```

#### A.ts

```ts
export const f = () => console.log("this is A.f")
```

このコードを以下の4パターンでトランスパイルしてみて、出力されるコードの変化を眺める

- tsc --module commonjs
- tsc --module esnext
- webpack (tsconfig#module=commonjs)
- webpack (tsconfig#module=exnext)

# tsc

## tsc --module commonjs

commonjsで読める形式にトランスパイルされる

nodejsでは実行できるが、そのままだとIEなどでは実行できなさそうだ

#### index.js

```js
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var A_1 = require("./A");
console.log("this is index");
A_1.f();
```

#### A.js

```js
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.f = void 0;
exports.f = function () { return console.log("this is A.f"); };
```

もともとのコードがESMなので以下の行がついている

> Object.defineProperty(exports, "__esModule", { value: true });


## tsc --module esnext

トランスパイル結果もESMとなる
これはちょっと古いnodejsだと読めない形式

#### index.js

```js
import { f } from './A';
console.log("this is index");
f();
```

#### A.js

```js
export var f = function () { return console.log("this is A.f"); };
```

# webpack+ts-loader

webpackでindex.tsファイルをビルドするときどうなるかをみてみる
typescriptの変換にはts-loaderを使う

```
$ npx webpack --mode none --entry ./index.ts --output ./out/bundle.js
```

以下の2パターンでどうなるかを確認する

- tsconfig#module=commonjs
- tsconfig#module=esnext

## tsconfig#module=commonjs

こんなjsが生成された

<pre>
/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var A_1 = __webpack_require__(1);
console.log("this is index");
A_1.f();


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.f = void 0;
exports.f = function () { return console.log("this is A.f"); };


/***/ })
/******/ ]);
<pre>

webpackは依存関係をすべて関数の配列として閉じ込めたjsを吐くようになっているが、
関数の配列に閉じ込められた部分は tsconfig.json が tsc で出力したものと同じようになっている

処理の中に exports が出てきているが、これは webpack が注入 (`Execute the module function` というコメントのあたり)しているもので、もちろんブラウザや標準で定義されている `exports` オブジェクトとは違うものとなっている


## tsconfig#module=esnext

もとは同じ index.ts だが、tsconfig.json によって webpack が違うコードを生成するのがわかる

```js
...

// 前半部分は module=commonjs と一緒なので省略

/* 0 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _A__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(1);

console.log("this is index");
Object(_A__WEBPACK_IMPORTED_MODULE_0__["f"])();


/***/ }),
/* 1 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "f", function() { return f; });
var f = function () { return console.log("this is A.f"); };


/***/ })
```


# 感想

- tsc は commonjs や ESM など、そのままで色んなブラウザが解釈できる形式までやってくれるわけではない
  - パスの解決とかまでは tsc はやってくれない。バンドルを作るためのソフトウェアではない
- webpack は commonjs や ESM をブラウザが解釈する形式まで落とし込んでくれる
  - webpack はバンドルを作るためのソフトウェアなのでそこを頑張ってくれる
