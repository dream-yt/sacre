---
title: "react-admin では ナチュラルキーのテーブルはうまく扱えない"
slug: react-admin-cant-handle-natural-key
date: 2021-04-25T15:10:37+09:00
draft: false
author: sakamossan
---

rails や django などのフレームワークと同様、idカラムがない(もしくはpkにナチュラルキーが設定されている)テーブルは react-admin ではうまく扱うことができない。

このissueでキッパリと扱えないと言われている。

- [[Feature Request] Support custom PrimaryKey as an option · Issue #3172 · marmelab/react-admin](https://github.com/marmelab/react-admin/issues/3172)

> We said several times in the past that we don't want to do that. It's a strong design decision, but it allows us to develop complex features with much better confidence.

FAQ の先頭でも同様の質問があり、回答されているのだがこのやり方は `react-admin=v3.14.4` の時点では実際に動作しない。動作させるためには挙げられている差分以外にも色々実装する必要がある。

- [React-admin - FAQ](https://marmelab.com/react-admin/FAQ.html#can-i-have-custom-identifiersprimary-keys-for-my-resources)


## pkがid以外の場合に実装の必要があるもの

無理矢理頑張ることもできるが、かなりメンテナンスコストがかさんでしまうのでそもそも楽をするために react-admin を採用しているならオススメできる方法ではない。

- 取得されたレコード行のpkカラムを `id` という名前に変える
- リクエストする sort/filter パラメータに `id` が含まれる場合テーブルのpk名に変換する
- アプリで1つのDataProviderを共用しているため、resource名ごとに分岐して

dataProvider自身はシンプルだがあまり拡張性の高い構造になっていないので、現実的には pk が idという名前でないテーブル (複合PKなど) は react-admin では使えないと考えたほうがよさそう。


## それでも管理したい場合

pkがidでないテーブルを扱う時は React-admin 組み込みでなく自前の実装の画面を作ることになる。自前の resource を追加する方法はこちらに案内されていた。

- [React-admin - Theming](https://marmelab.com/react-admin/Theming.html#using-a-custom-menu)

ただし、それも組み込みのサイドバー/メニューバーのコンポーネントを再実装するという方法しかないようであまり現実的ではなさそうだった。1テーブルだけpkがidでないテーブルがあるだけで、デフォルトの出来のいいメニューバーに匹敵する車輪の再発命をして、それをメンテし続け
る必要があるのは割が合わなそうである。おとなしくAPIサーバ側の処理で吸収した方がよさそうである。

## 結論

React-admin は rails や django などと同様にオートインクリメントのサロゲートキーを使う想定で作られている。もしそうでないテーブルを管理する必要がある場合は、サーバ側でうまいこと処理を書いてあげる必要がある。テーブルを作るときも、pk は integer/autoincrement にして、ナチュラルキーのほうは unique 制約をつけるようにしておくのがよい。

