---
title: "入門監視の読書メモ"
date: 2019-05-19T15:19:54+09:00
draft: false
author: sakamossan
---

<a href="https://www.amazon.co.jp/%E5%85%A5%E9%96%80-%E7%9B%A3%E8%A6%96-%E2%80%95%E3%83%A2%E3%83%80%E3%83%B3%E3%81%AA%E3%83%A2%E3%83%8B%E3%82%BF%E3%83%AA%E3%83%B3%E3%82%B0%E3%81%AE%E3%81%9F%E3%82%81%E3%81%AE%E3%83%87%E3%82%B6%E3%82%A4%E3%83%B3%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3-Mike-Julian/dp/4873118646/ref=as_li_ss_il?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&keywords=%E5%85%A5%E9%96%80%E7%9B%A3%E8%A6%96&qid=1558243823&s=gateway&sr=8-1&linkCode=li3&tag=rocklaakira-22&linkId=587681fbd4cf11eabed2d04e6a217453&language=ja_JP" target="_blank"><img border="0" src="//ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=4873118646&Format=_SL250_&ID=AsinImage&MarketPlace=JP&ServiceVersion=20070822&WS=1&tag=rocklaakira-22&language=ja_JP" ></a><img src="https://ir-jp.amazon-adsystem.com/e/ir?t=rocklaakira-22&language=ja_JP&l=li3&o=9&a=4873118646" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />

後から見返したり、おぼえておきたいことをメモ

---

#### OSのメトリクスだけを対象にしたアラートは意味が薄い

- メトリクスが悪くなってもサービスに影響を与えているとは限らない
- サービスを監視したい場合は、OSのメトリクスではなくてサービスを監視する
    - もちろんOSのメトリクスが原因であることもあるが、サービスを監視するほうが直接的でシンプル


### メトリクスは高頻度で取得して良い

- 最低でも1分に1回取得する
    - 0.02 QPS (1分に1回) で負荷が上がるシステムはきょうびないはず
- とったメトリクスの保管期限/情報の圧縮方法は検討する必要がある


### たとえば AWS EC2の可用性は99.95%

- AWS EC2 はインフラのインフラと呼べる部分
    - それでも年間4時間のダウンタイムは許容している
- これ以上の可用性を普通のサービスに求めるのは不合理と言える


### ユーザ側のコンポーネントから監視する

- サービスはユーザのためのものなので、ユーザに近いところが監視の優先順位は高い
- たとえば、DBのIOPSではなくHTTPのステータスコードから監視する


### 障害対応時の役割には名前がある

- 現場指揮官
    - リスクとトレードオフを鑑みて決断をするのが仕事
    - システムの設計を理解しているエンジニアが担当する
- スクライブ (書記)
    - 起こったことを記録する
        - 誰が何をしたのか
        - 誰が何を決断したのか
- コミュニケーション調整役
    - ステークホルダーに説明をする
    - マネージャが担当する
- SME (subject matter expert)
    - 実際に障害対応をする人
    - 当該コンポーネントに詳しいエンジニアが行う


### ビジネスKPIを監視する

たとえば

- ログイン成否の比率
- 購入失敗 / 購入のレイテンシ
- サイトに滞在しているユーザ数

ユーザのサイト内での行動の成否とそのレイテンシはビジネスKPIとなりうる


### フロントエンドのNavigationTimingAPI

いくつかあるが重要なもの

- navigationStart
    - サイトへのリクエストを開始したタイミング
        - URLを入れてエンターを押したタイミング
    - 途中のリダイレクトよりも前
    - DNS, TCPコネクションよりも前
- domLoading
    - html、DOMのレスポンスが返ってき終わったところ
    - ブラウザが最初に受け取った HTML ドキュメントのバイトの解析を開始する時点
- domInteractive
    - 受け取ったhtmlをもとにブラウザがDOMを生成できた時点
- domContentLoaded
    - DOMが構築できて、かつjsの実行ができるようになった時点
        - CSSの描画/計算が残ってるとjsは実行できない
- domComplete
    - 画像などのページ内のリソースがすべて表示できたタイミング
    - ブラウザの読み込み中のマークの回転が止まった状態


##### 参考

- [クリティカル レンダリング パスの測定  |  Web  |  Google Developers](https://developers.google.com/web/fundamentals/performance/critical-rendering-path/measure-crp?hl=ja)
- [PerformanceNavigationTiming - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/PerformanceNavigationTiming)


### データベースサーバの基本的な監視

- コネクション数 (MySQLだとスレッド数)
- 秒間クエリ数 (QPS)
- IOPS
    - DBにとってディスクが健全なのかは基本的な監視


### セキュリティ監視

ふたつのツールが紹介されていた

- auditd
  - sudoの記録、ファイルの変更などを監視
- rkhunter
  - rootkitが何かしてたら検知するソフトウェア


### healthエンドポイント

- httpでシステムの状態を返してくれるパスを用意しておくのは良いアイデア
- CNCFではOpenMetrics(Prometheusの形式)という仕様のプロジェクトを持っている
    - [CNCF、OpenMetricsをSandboxプロジェクトとして受け入れ、Prometheusは卒業 | OSDN Magazine](https://mag.osdn.jp/18/08/13/193000)
- [Health Check Response Format for HTTP APIs](https://tools.ietf.org/id/draft-inadarei-api-health-check-02.html) という標準仕様が議論中
    - [返されるJSONの例](https://gist.github.com/kinlane/5bea1128ccada3b26ab534b7e4bb138d)
