---
title: "SameSite Cookie とは"
date: 2019-07-11T12:25:34+09:00
draft: false
author: sakamossan
---

こういう機能

> 今開いているページのドメインから、別のドメインにリクエストを送る際に、
> クッキーを送るかどうかを設定できる機能

`別のドメインにリクエストを送る` とは以下の例がある

- 広告タグで広告サーバへリクエスト
- トラッキングタグでGoogleAnalyticsなどでリクエスト
- リンク(aタグ)で別ドメインへ遷移

個人的にはリンクで遷移した場合も `別のドメインへのリクエスト` として扱うのが新しい感じ


## 例

- dmm.jp が SameSiteがついたSet-Cookie しておくと
- ユーザが twitter.com のアクセスしているときに
- dmm.jp の広告にあたって、アドリクエストが発生した時
- dmm.jp へのリクエストにはCookieが送信されなくなる


## 設定のしかた

Set-Cookie するときに `samesite={strict,lax}` を付与するだけ

```
Set-Cookie: test=1; path=/; samesite=strict
```

### laxとstrictの違い

こちらが分かりやすかった

- [HTTP クッキーをより安全にする SameSite 属性について (Same-site Cookies) | ラボラジアン](https://laboradian.com/same-site-cookies/)


## 用途

CSRF対策になる

銀行などのガッチリ守りたいところでは
samesite=strictとしておくと防御力があがる


## 対応ブラウザ

だいたい主要なブラウザでは対応済み

- [Can I use... Support tables for HTML5, CSS3, etc](https://caniuse.com/#feat=same-site-cookie-attribute)

