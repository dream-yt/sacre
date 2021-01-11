---
title: "Googleタグマネージャ入門"
slug: google-tag-manager-101
date: 2021-01-11T10:57:42+09:00
draft: false
author: sakamossan
---

- Googleタグマネージャ(gtm)はタグを管理するツール
- 条件、イベントを設定して任意のタイミングでタグを発火させるツール
- 多くの場合はGoogleアナリティクス(ga)のタグを発火させる
    - データの蓄積と閲覧はga側でやる

## 概念

Googleタグマネージャの説明では以下の概念が出てくる。

- タグ
- トリガー
- 変数
- コンテナ

### タグ

タグとは普通にhtmlタグのこと。

DMP事業者のトラッキングタグをUIから登録してよしなに配信されるようにする。
( `配信` とはユーザのブラウザ上で発火させるということ)

gaやyahooなどよく使うタグなどは登録しないでも使えるようになっている。


### トリガー

トリガーとは「どういう条件のときにタグを配信するか」という条件のこと。
たとえばデフォルトで用意されているものでもたくさんある。

- [トリガーの種類 - タグマネージャ ヘルプ](https://support.google.com/tagmanager/topic/7679108)


### 変数

トリガーで使ったり、gaに投げたりするときに使う変数。
計測されたデータを集計するときに役にたつような変数を上手く使うと便利になる。

たとえば現在ユーザが閲覧しているページのURLは `Page URL` という変数として設定できる。
この値をトリガーの条件などに使える。

- [組み込み変数 - タグマネージャ ヘルプ](https://support.google.com/tagmanager/topic/7182737)
- [ユーザー定義変数 - タグマネージャ ヘルプ](https://support.google.com/tagmanager/topic/9125128?hl=ja&ref_topic=7683268)

##### 変数をつかうとこんなことができる例

- このページのh1要素のテキスト(変数)が `.+詳細` という正規表現にマッチする場合にタグを出す
- ページ閲覧時にjsのdataLayer.myvalの値(変数)をgaに投げる
    - jsのdataLayerオブジェクトの中身を変数として使うことができる

### コンテナ

複数ドメインにまたがったタグ制御ももちろんできる。
いったんgaでいう **サイト** のことという理解で良い。

管理上の概念なのでそんなに意味はない。


---

以下はその他のtips

### タグマネージャで管理できないタグ

- 同期処理が必要になるもの (基本は非同期処理をするタグが想定されている)
- 画面の表示を変更するもの
    - 例: SNSのシェアボタン


### jsの処理でタグの配信タイミングを制御する

gtmでは任意のタイミングでタグを配信したい場合は以下の手順になる

- イベント名を変更する処理を実装
- 「イベント名が `[[ event_name ]]` になったとき」というトリガーを作成しておく
- 配信したいタグとトリガーを紐付け

イベント名を変更する処理は以下の通り

```js
dataLayer.push({'event': '[[ event_name ]]'});
```

##### 参考

公式でも紹介されている方法となっている

- [Developer Guide  |  Google Tag Manager for Web Tracking  |  Google Developers](https://developers.google.com/tag-manager/devguide)
- [Googleタグマネージャに自在にデータを渡す「データレイヤー変数」（全20回の19） | 実践 Googleタグマネージャ入門 | Web担当者Forum](https://webtan.impress.co.jp/e/2015/03/18/18983)


### その他のタグの配信タイミング

デフォルトで用意されているトリガーは色々ある

- [トリガーの種類 - タグマネージャ ヘルプ](https://support.google.com/tagmanager/topic/7679108)
- [クリック トリガー - タグマネージャ ヘルプ](https://support.google.com/tagmanager/answer/7679320?hl=ja&ref_topic=7679108)
- [JavaScript エラートリガー - タグマネージャ ヘルプ](https://support.google.com/tagmanager/answer/7679411?hl=ja&ref_topic=7679108)

jsで制御しなくても「クリックされたリンクのURLが正規表現にマッチする場合」といった条件は管理画面から設定できるようで、大体の場合でjsで制御する必要はないかもしれない


### ページ内のテキストを変数として使う

pageのURLやクエリパラメータはデフォルトの機能で変数として使える。

ページのtitleやh1要素も次のようにすれば変数として扱える。

- 内容を変数として扱いたいDOMにid属性を払い出しておく
- 変数の設定で目当てのDOM要素のIDを参照するように設定

##### 参考

- [DOM要素 | ウェブ用のユーザー定義変数タイプ - タグマネージャ ヘルプ](https://support.google.com/tagmanager/answer/7683362?hl=ja#dom_element)


### gtmで使える変数をjsから登録する

jsからdataLayerというオブジェクトを通して変数が登録できる

```js
dataLayer.push({'Data Layer Name': 'value'}).
```

- [dataLayer | ウェブ用のユーザー定義変数タイプ - タグマネージャ ヘルプ](https://support.google.com/tagmanager/answer/7683362?hl=ja#data_layer)


### 仮想ページビューの計測

たとえばpdfファイルの閲覧数など、タグが発火しないところのビュー数を計測したい場合、**仮想ページビューの計測** ということにして計測する。
「このリンクがクリックされたとき」といったトリガーを設定して計測できる。


# Googleアナリティクス

gtm(Googleタグマネージャ)はgaをセットで使うのでgaの概念と連携する方法も書く


### 概念

- ディメンション
- 指標

ディメンションはSQLでいうところのGroupBy句に渡したくなる値で、
指標はSQLでいうところのSUMとかの集計関数に入れたくなるような値と言える

- [ディメンションと指標 - アナリティクス ヘルプ](https://support.google.com/analytics/answer/1033861?hl=ja)


### 連携方法

gtmを使ってgaにデータを投げて、蓄積閲覧できるようにするということは
gtmで設定したトリガーからgaのイベント計測タグを配信することになる

gtmの管理UIはgaとよくインテグレーションされていて、
gaのイベント計測タグを配信する際にはディメンションと指標の値を送信できるようになっている

- [Google アナリティクスのカスタム ディメンション - タグマネージャ ヘルプ](https://support.google.com/tagmanager/answer/6164990?hl=ja)
