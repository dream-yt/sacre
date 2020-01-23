---
title: "browserifyからwebpackに移行するときのエラー"
date: 2020-01-23T17:46:27+09:00
draft: false
---

browserifyのcommonjsと、webpackのcommonjsの違いにハマったときの話

## 経緯

browserifyからwebpackに移行するときに、ある古いライブラリが読み込み時エラーとなってしまった
その古いライブラリはモジュール解決のロジックを以下のように行なっていた

```js
	if ( typeof define === 'function' && define.amd ) {
		// AMD
		define( ['jquery'], function ( $ ) {
			return factory( $, window, document );
		} );
	}
	else if ( typeof exports === 'object' ) {
		// CommonJS
		module.exports = function (root, $) {
```

- [DataTables/jquery.dataTables.js at master · DataTables/DataTables](https://github.com/DataTables/DataTables/blob/master/media/js/jquery.dataTables.js#L30-L38)

browserifyでモジュール解決をしていたときは名前空間に `define` がなかったため無事にcommonjsとしてモジュールを読み込めていたが、webpackでビルドすると名前空間に `define` が存在し、分岐の結果AMDとしてモジュールを読み込もうとしているようだった

これまでbrowserify(commonjs)でビルドしていたので、このファイルのみAMDで読み込むことになりエラーになった


## commonjsとAMD

両方ともjsでモジュールを読み込むための仕様

commonjsはnodejsで使われており、AMDはブラウザ側で使うために作られた (クライアント側が通信してjsファイルを取ってくるといったことをする)

datatable.netはcommonjsとAMDを背反なものとして分岐させているが、実際にはcommonjsとAMDを同時に動作させるといったことも行われているようだ


### 参照

commonjsのwikiにAMDの仕様がPROPOSALであがっていたり

- [Modules/AsynchronousDefinition - CommonJS Spec Wiki](http://wiki.commonjs.org/wiki/Modules/AsynchronousDefinition)

commonjsのwikiにメーリングリストにAMDを別口に分けようとするスレッドがあったりする

- [Split off AMD? (was Re: [CommonJS] New amd-implement list) - Google グループ](https://groups.google.com/forum/#!searchin/commonjs/define%7Csort:date/commonjs/lqCWO8tMp48/gRqjWVP4364J)

もともとこの辺りのスニペットをコピペしたライブラリなのかもしれない

- [umd/returnExportsGlobal.js at master · umdjs/umd](https://github.com/umdjs/umd/blob/master/templates/returnExportsGlobal.js)


## 解決方法

説明から遠回りしたが、今回の問題はつまるところ次の点に尽きる

- browserifyのcommonjsではAMDが有効になっていないが
- webpackのcommonjsではAMDが有効になっている
  - コンパイル時のグローバル名前空間に `define` 関数が存在している

なのでwebpackの設定でAMDを無効にした

- [ruleparser | Module | webpack](https://webpack.js.org/configuration/module/#ruleparser)

```js
module.exports = {
  module: {
    rules: [
      {
        parser: {
          amd: false, // disable AMD
        }
      }
    ]
  }
}
```

この設定でbrowserifyでビルドできていたときと同じ動作にすることができた
