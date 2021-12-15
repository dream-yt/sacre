---
title: "Google Analytics 4 でページ表示速度を計測する"
slug: setup-google-analytics4-and-bigquery
date: 2021-12-15T15:29:21+09:00
draft: false
author: sakamossan
---

Google Analytics はこれまでのユニバーサルアナリティクス(UA)だとページの表示時間がデフォルトで計測されていた。
しかし、Google Analytics 4 (GA4)からはその指標がなくなってしまっているようだ。

> Unlike Universal Analytics, Google Analytics 4 doesn’t measure site speed.

- [10 things to know before moving from Universal Analytics to GA4](https://supermetrics.com/blog/google-analytics-4-connector)

GA4 は BigQuery とも簡単に連携が可能になっているので「ページの表示速度を BigQuery で確認できたらよさそうだな」
と思って移行したのに肝心の指標がとれていないとなってけっこう脱力したが、カスタムイベントとして計測して集計することにした。



## やること

まず、各種サービスにログインして環境整備。

- [x] Google Analytics 4 のプロパティを作成する
- [x] Google Tag Manager の設定
- [x] タグの埋め込み
- [x] 作成したプロパティと BigQuery と紐付けをする

環境が作成できたら実際にイベントを発火させて確認していく。

- [x] GA4 のコンソールからイベントを作成
- [x] Chrome Analytics Debugger を入れる
- [x] GA4 の DebugView から確認
- [x] Chrome開発ツールでイベントを発火させる

イベントが発火するところまでが確認できたら、BigQueryで期待通りに計測されているかを確認する。

- [x] BigQuery で確認


## 各種サービスへのログイン

これはとくに難しいこともない。公式のドキュメントでもいいし、検索すればいろいろでてくる。

#### Google Analytics 4 のプロパティを作成する

- [トラッキング ID を確認する - アナリティクス ヘルプ](https://support.google.com/analytics/answer/9539598?hl=ja)

ちなみに、現在使っているのが GA4 なのか UA なのかの判定は ID の形式でできる。

> トラッキング ID が表示されない場合、お客様は Google アナリティクス 4 プロパティをご利用です（Google アナリティクス 4 プロパティにはトラッキング ID はありません）。

#### Google Tag Manager の設定 & タグの埋め込み

- [タグ マネージャーの設定とインストール - タグ マネージャー ヘルプ](https://support.google.com/tagmanager/answer/6103696?hl=ja)

公式ドキュメントだけだとそれぞれの用語の意味がわからないので適宜検索

- [GTM（Googleタグマネージャー）とは？基礎知識と導入・初期設定](https://satori.marketing/marketing-blog/what-is-marketing/gtm-basic/)


#### 作成したプロパティと BigQuery と紐付けをする

これも公式に案内があるので、GCP のプロジェクトがすでにあるならば簡単におわる。

- [[GA4] BigQuery Export のセットアップ - アナリティクス ヘルプ](https://support.google.com/analytics/answer/9823238?hl=ja#zippy=%2C%E3%81%93%E3%81%AE%E8%A8%98%E4%BA%8B%E3%81%AE%E5%86%85%E5%AE%B9)


## カスタムイベントの作成とテスト

この辺りはやりたいことによって作業がまちまちなので、ドキュメントにジャストな項目が見つからない。

#### GA4 のコンソールからイベントを作成

この記事がよかった。

- [GA4に新たに追加された「イベントを作成」機能](https://ayudante.jp/column/2020-11-11/11-00/)

今回はサイトの表示速度が計測したいので、ページの DomContentLoaded イベントなどを追うようにする。

カスタムイベントは gtag 関数に色々引数を渡して発火させる。

このように gtag 関数を呼ぶと `google-analytics.com` にビーコンが飛んで計測される様子を Chrome開発ツールでみることができる。

```js
gtag('event', 'timing_complete', { value });
```

ここでいう第二引数の `timing_complete` がコンソールから設定する event_name となるので、イベントを作成するときはそれを念頭におくとよい。


#### Chrome Analytics Debugger を入れる

これを入れる。

- [Chrome ウェブストア - 拡張機能](https://chrome.google.com/webstore/detail/google-analytics-debugger/jnkmfdileelhofjcijamephohjechhna)

これを入れた状態で GA4 が動いているページのコンソールを開くとログがたくさん出てくれて、デバッグしたい時に役に立ちそう。


#### GA4 の DebugView から確認 & Chrome開発ツールでイベントを発火させる

GA4 の DebugView のタブを開いた状態で、Chrome開発ツールからイベントを発火させてみる。
DebugView で見るためには `debug_mode: true` の指定が必要なのでこれをつける。

こんなコードを仕込んで、GA4 にちゃんとイベントが届いているかを確認する。

```js
function gtag(){window.dataLayer.push(arguments);}
gtag('js', new Date()); 
gtag('config', 'G-J15XXXXX');
gtag('event', 'timing_complete', { value, debug_mode: true });
```

#### BigQuery で確認

BigQuery の連携設定を1日1回にしていたので、計測結果を BigQuery で見るのは1日待った。

こんなクエリで今回追加した `timing_complete` イベントの内容が確認できた。

```sql
SELECT event_date,
    event_timestamp,
    event_name
FROM `myproj.analytics_813456732.events_20211214`
where event_name = 'timing_complete'
LIMIT 5
```
