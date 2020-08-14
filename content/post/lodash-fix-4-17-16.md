---
title: "lodash@4.17.16 の脆弱性修正について"
date: 2020-07-28T12:23:16+09:00
draft: false
author: sakamossan
---

`4.17.16` にていくつかの脆弱性が修正されている

- [Releases · lodash/lodash](https://github.com/lodash/lodash/releases)

`template`, `zipObjectDeep` あたりを使ってトリッキーなコードをかいていなければ挙動に変更はなさそうである


### sourceURLに改行をふくめないように

差分はこちら

- [Sanitize sourceURL so it cannot affect evaled code (#4518) · lodash/lodash@e7b28ea](https://github.com/lodash/lodash/commit/e7b28ea6cb17b4ca021e7c9d66218c8c89782f32)

ブラウザにはsourceURLという仕組みがあり、デバッグ時のコードの断片に名前をつけておくことができる。これはevalされるコードやインラインのjsコードをデバッグしたい時に使われる

- [eval ソースをデバッグする - 開発ツール | MDN](https://developer.mozilla.org/ja/docs/Tools/Debugger/How_to/Debug_eval_sources)

sourceURL の記法はインラインコメントにて定義するというものだが、インラインコメントなのでこの文字列に改行を含められてしまうと、コメント外に任意のjsコードが配置できるということになってしまう

これまでは `[\r\n]` をサニタイズしていたが、マルチバイトの改行文字列もサニタイズしとかないといけなかったということで `\s` をサニタイズするように変更されている。そもそも sourceURL に特殊な不可視文字は必要ないのだろう


### prototype pollution 対応

差分はこちら

- [fix(zipObjectDeep): prototype pollution (#4759) · lodash/lodash@c84fe82](https://github.com/lodash/lodash/commit/c84fe82760fb2d3e03a63379b297a1cc1a2fce12)

jsではオブジェクトの `prototype`, `constructor` といった名前の属性が特別な意味を持っているが、jsは動的な言語なのでこれらの属性は後から書き換えることができてしまう。

この特性が悪用される脆弱性を `prototype pollution` と呼ぶ。たとえばライブラリをロードしただけで `jQuery#ready` が突然ファーウェイと通信し始めたりするとよろしくないということだ

対応は単純に特殊な名前の属性は処理をスキップするというもの
