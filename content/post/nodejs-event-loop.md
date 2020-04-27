---
title: "nodejsのEvent Loopについておおまかなメモ"
date: 2020-04-19T13:35:05+09:00
draft: false
---

nodejsのイベントループは次の6個のフェーズからなる

- timers
- pending callbacks
- idle, prepare
- poll
- check
- close callbacks

この6個のフェーズの1周はラウンドと呼ばれる

それぞれのフェーズはそれぞれのキュー(実行すべき処理のリスト)をもっている

また、それぞれフェーズごとのキューとは別に2つキューがある
この2つのキューは各フェーズとフェーズの合間に消化される

- nextTickQueue
  - `process.nextTick` で登録されたコールバックがはいるキュー
- microTaskQueue
  - `Promise` オブジェクトに登録されたコールバックはこのキューに入る


# それぞれのフェーズ

どういった経路で登録されたコールバックかによって実行されるフェーズが違う


### timers

`setTimeout`, `setInterval` で設定されたイベントが処理される


### pending callbacks

IOエラーに伴うコールバックが処理される

たとえば、`ECONNREFUSED` が返ってきてる場合などはこのフェーズで処理される


### idle, prepare

内部的な処理を行うフェーズで普段ユーザは意識しない


## poll

このフェーズはカーネルに依頼した処理のポーリングなど

- IOなどのポーリング (ブロックしてポーリングする)
- ポーリングキューの結果実行できるようになったイベントの処理

ポーリングは必ずしも処理が完了するまで待つのではなく、そのときそのときでリーズナブルな待ち時間を計算してその分だけ待つことになっている (その待ち時間で結果が返ってこなかったら次のラウンドに持ち越す)

なお、IOエラーが返ってきた場合はこのフェーズでは処理されず、次のラウンドのpending callbacksまで処理が持ち越される


### check

`setImmediate` で登録された処理が実行される


### close callbacks

`close` イベントを処理する 

- eg: `readable.on('close', () => {})`

`close` はたとえば `socket.destroy()` などでも発生する


# 参考

イベントループにはもっと知っておくべきことや詳細な実行順序などがある  
(たとえば nextTickQueue, microTaskQueue では nextTickQueue のほうが先に処理されることなど)

- [The Node.js Event Loop, Timers, and process.nextTick() | Node.js](https://nodejs.org/uk/docs/guides/event-loop-timers-and-nexttick/)
- [Node.jsでのイベントループの仕組みとタイマーについて - 技術探し](https://blog.hiroppy.me/entry/nodejs-event-loop)

