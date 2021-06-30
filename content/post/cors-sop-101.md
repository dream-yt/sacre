---
title: "CORSやSOPについての基礎的な知識"
slug: cors-sop-101
date: 2021-06-30T17:35:28+09:00
draft: false
author: sakamossan
---

CORS(Cross-Origin Resource Sharing)や、SOP(Same-Origin Policy) については知っておくべきことは3種類。

- オリジンの判定ルール
- オリジンが違う場合の制限
- 制限を回避するための方法


## オリジンの判定ルール

以下が3つとも同じなら、ブラウザは同じオリジン(Same-Origin)と判断する。

- ホスト
  - サブドメインが違う場合も異なるオリジンとなる
- ポート
- スキーム
  - http or https


## オリジンが違う場合の制限

下記の場合にはブラウザはSOPに従う(制限をかける)

- 異なるオリジンへはXMLHttpRequestでリクエスト出来ない
- 異なるオリジンのiframeオブジェクトをjsから触ることが出来ない
- 異なるオリジンのlocalStorageを参照することは出来ない

他にも細かい制限は存在するが、よく遭遇するのはこの3つである。

cookieはまたもうちょっと色々あるので注意。


## 制限を回避するための方法

制限を抜けたい場合はクロスオリジン先(サーバ側)に協力してもらう必要がある。
サーバ側にCORSヘッダを返してもらうようにして、ヘッダ情報からクロスオリジンを信頼してもいいという指示がある場合、
ブラウザは制限を解除して動作してくれる。


## 参考

- [同一オリジンポリシー - Web セキュリティ | MDN](https://developer.mozilla.org/ja/docs/Web/Security/Same-origin_policy)
- [HTTP アクセス制御 (CORS) - HTTP | MDN](https://developer.mozilla.org/ja/docs/Web/HTTP/HTTP_access_control)

wikipediaもわかりやすかった。

- [同一生成元ポリシー - Wikipedia](https://ja.wikipedia.org/wiki/%E5%90%8C%E4%B8%80%E7%94%9F%E6%88%90%E5%85%83%E3%83%9D%E3%83%AA%E3%82%B7%E3%83%BC)
