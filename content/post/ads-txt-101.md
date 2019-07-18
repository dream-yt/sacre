---
title: "ads.txt入門"
date: 2019-06-27T17:17:06+09:00
draft: false
---

ads.txtという仕様がIABから出されている

- [ads.txt - Authorized Digital Sellers - IAB Tech Lab](https://iabtechlab.com/ads-txt/)


## 概要

- ads.txtはメディアのドメイン配下に置かれるtxtファイル
- 枠を買い付ける側が参照するもの
- 広告配信システムとの関係を記述するためのもの
  - そのメディアが利用しているSSPを明示する
  - リセラーがいる場合それをはっきりとさせる


### 利用しているSSPを明示?

悪意のあるサイトが、メディア名を騙ってadリクエストをする場合がある

1. 訪問がないのにSSPにadリクエストを送る
1. SSPとDSPでオークション
1. adレスポンスをつかって悪意あるサイトが広告を表示/クリック
1. 落札金額が悪意あるサイトに支払われる

メディアとSSPの関係性がはっきりとしていればこういった詐欺はできなくなる

具体的には、ads.txtではSSP内のメディアIDを載せることになっていて、
DSPがそのメディアIDへと支払いを行うようにすれば悪意あるサイトにはお金が流れない


### リセラー?

メディアとDSPの間に複数の広告事業者(リセラー)が入ってくる場合がある

1. メディアが枠をSSPに売る
  - 枠のタグからSSPにadリクエストが投げられる
1. SSPがその枠をリセラーに売る
  - SSPがs2sでリセラーに bidリクエストを投げる
1. DSPはリセラーから枠を買うことになる
  - リセラーがbidリクエストを横流ししてDSPからbidレスポンスを受け取る

リセラーが産む付加価値は小さいので多くの場合こういった構造は歓迎されない
知らないうちにリセラーが入り込んでいるという状況が発生しないようにメディアはads.txtを設置して、
リセラーがいない、ないしは自らが認めているリセラーをはっきりとさせておくことができる


## 仕様

#### 場所

配置するのはメディアのトップレベルドメイン直下のパス `/ads.txt`
たとえば `https://www.facebook.com` というURLのメディアに置くなら以下の場所になる

> https://facebook.com/ads.txt


#### 内容

カンマ区切りの4カラムで1レコード

- SSPのドメイン
- SSPがそのメディアに払い出したID
- 管理タイプ ( `DIRECT` or `RESELLER` )
- (任意) TAGという認証団体からSSPがもらっているID

このレコードは使っているSSPごとに必要
たとえばgoogleとopenxを使っているなら以下のような2レコードとなる

```
google.com, pub-3004679189235742, DIRECT, f08c47fec0942fa0
openx.com, 537149074, DIRECT, 6a698e2ec38604c6
```

必須ではないものとしては以下のふたつ



## その他

形式があっているかをチェックしてくれるサービス

- [Ads.txt Manager | DataSign FE](https://fe.datasign.co/adstxt/)