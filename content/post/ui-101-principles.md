---
title: "[読書メモ] インターフェイスデザインのお約束"
date: 2019-11-18T15:09:20+09:00
draft: false
---

- [O'Reilly Japan - インタフェースデザインのお約束](https://www.oreilly.co.jp/books/9784873118949/)

# 2章 文字と言葉

## 010 log-in より sign-in

- log-in ではなく sign-in を使った方がよい
- ただし、日本語では「ログイン」のほうが一般的なのでそちらを使う


## 013 受動態は使わない

- 能動態を使う
- 受動態はなるべく使わない
- だいたいの文章は能動態のほうがわかりやすい


#### 例

> この問題は担当者によって処理されます

よりも

> 担当者がこの問題を処理します

のほうが直接的な言い方だ


# 3章 UI部品

## 015 時代に合わせたアイコンを使う

- フロッピーなど、もう使われてない機器をアイコンに使うのはやめる
- そろそろ(サーバーに)保存するボタンなどはこういうのが使われるかも

![image](https://user-images.githubusercontent.com/5309672/68736148-36215e80-0623-11ea-92af-4932d7c4dbcf.png)


## 017/018 アイコンの中の文字

アイコン画像の中、画像として文字が入ってるのはご法度

- 画像は翻訳できないため
- 画像は読み上げができないため

ただし、画像でなく文字列としてアイコンにラベルを添えるのはよいこと

- 意味の微妙なアイコンは不満になりやすい
- アイコンの意味が明確だとサイト内のナビゲーションがわかりやすくなる

なお、モバイル版の小さい画面でもラベルは大事なので必須


## 019 emojiを使う

emojiを積極的に使う

- emojiはいまや、世界でもっとも一般的なアイコン
- その言語が読めない人でも理解できうる点も強力


## 020 ファビコンのお約束

ファビコンは特徴的である必要がある

ファビコンが目立つといいことがある

- たくさんのタブからすぐに見つけられるようになる
- たくさんのアプリアイコンからすぐに見つけられるようになる


#### ファビコンを作る際のポイント

- 16x16 サイズでの見た目の確認
- 背景を透過しておく (ブラウザのテーマがDark Modeでもよいように)


## 022 ボタンは押せるような見た目に

筆者はフラットデザインにはアンチの立場のようだ

- 現実のボタンは常に押せるかどうか分かりやすくなっている
- 現実でもタッチパネルのボタンのような平面的なものは分かりにくくなっている

こんな主張をしている

- ボタンが押せるかどうかがわかるべき
- それには影などのモディファイアをつけるのがシンプルでよいはず
- また、ボタンでないものは「クリックできない」ということがわかるべき


## 024 ボタン上のカーソル

クリックできるボタン/リンクは、マウスオーバーでカーソルを指差しにするべき


## 027 独自のUI部品を作らない

- フォームのコントロールなどのUI部品はブラウザデフォルトのものを使う
- ブラウザ/OSが提供しているUI部品は歴史があり、莫大な投資で生み出されたもの
- 我流のUI部品はユーザに学習コストを請求するし、おそらく既存より完成度は低い

#### 例

- 日付を選択するピッカーは `<input type='date' />` を使う
- 独自に実装したプルダウンで日付を選ぶ。とかはしないようにする


## 030 スライダーの使い所

スライダーが活躍できる状況は多くない

- スライダーで正確な数値を入れるのは難しい
- スライダーは正確な数値が必要ない項目のみに使う
  - 音量など


## 032 ドロップダウン

ドロップダウン(セレクトボックス)にはお約束がある

### 選択肢の数

- 選択肢が2,3個ならラジオボタンなど違うフォームコントロールを検討すべき
- 選択肢がとても多い場合は検索できるようにする
  - モバイルの場合は多少マシなので検索できなくてよいかも
- 理想的な選択肢の数は7±2
  - それよりも多いならサブカテゴリなどの階層化を検討する

### 並び順

- 項目とマッチした並び順にするべき
  - 都道府県なら辞書順ではなく北から順番に並んでいてほしい


## 035 誤タップしないボタンの距離

誤タップを防ぐためにはボタン同士の感覚が2mmは必要 (最低限)


# 4章 フォーム

## 038 フォームは面倒臭い

フォーム入力の項目は少ない方がいい

- パスワード入力欄は1つ
  - 確認用の再入力欄は不要
  - ただしパスワードリセット機能を用意する
- 住所の入力はさせない
  - どうしてもの場合はなぜ住所情報が必要なのかを明示的に書く


## 041 フォーム入力には寛容であるべき

ユーザの入力に対してできるだけ寛容であるべき

- 本質的に必要最低限なバリデーションのみにするべき
- ユーザは不可解な入力をするが、それにもユーザ側には必ず理由がある

### 例

- 数値欄の中のカンマを許容する
- 電話番号欄の中のカッコやハイフンを許容する


## 042 inputのautocomplete

ブラウザのautocomplete属性を使う

- [HTML の autocomplete 属性 - HTML: HyperText Markup Language | MDN](https://developer.mozilla.org/ja/docs/Web/HTML/Attributes/autocomplete)

`"email"` や `"current-password"` など、ブラウザによって埋めてくれるものがある


## 044 メールアドレス欄

エッジケースが多すぎるので、メールアドレスの検証は厳格にはしない  
ただし、到達確認のワンクリックリンクのメールを送ること


## 049 ユーザの入力は消さない

ユーザがフォームに入力した内容は、指示のない限り絶対に消してはいけない

モバイルで頑張って入れた文字が消えるのはとても辛い


## 051 & 052 パスワード欄

パスワード欄にはお約束がいろいろある

- デフォルトは `*` で隠すようにしておく
- ただしチェックボックスで見れるようにもしておく
  - パスワードマネージャを使っている人は多数派ではない
  - ほとんどの人はパスワードを手動でいれている
  - フォーム欄をペースト可能にもしておく


## 054 パスワード再設定

パスワード再設定にもお約束がある

- リンク名は「パスワードを忘れた?」一択
  - ユーザがもっともわかりやすい表現を使う
  - それ以外のケースは悪意のあるユーザにしかない
- ワンタイムリンクは
  - 再設定が終わったら無効にする
  - 再設定が終わってなくても一定時間経過後で無効にする


# 5章 ナビゲーション

## 056 初心者の空っぽのページ

- 空っぽの初期ページは、初心者向けのアドバイスができるところ
- ただし、チュートリアルはスキップできるようにしておく


## 058 無限スクロール

無限スクロールにはお約束がある

- ユーザがどこまでスクロールしたのか保存しておく
  - 他のサイトに遷移して、戻るボタンで戻った時に元の場所に戻れるように
- フィードのように時系列表示するようなコンテンツでつかう
  - 最初と最後があるコンテンツはページングを使う
  - 「最後から2ページ目が見たい」という場合があるならページング


## 062 - 065 ユーザージャーニー

ユーザージャーニーという概念がある

これはユーザが目的を完遂するまでの一連のUI操作の集合のことで、たとえばtwitterでいうとユーザージャーニーには「設定から表示名を変更する」とか「ハッシュタグから最新情報を探す」「ツイートする」といったものがある


ユーザージャーニーにもお約束がある

### ユーザージャーニーの完了を明示的にする

ユーザの目的が完遂できたのかどうかをわかりやすくする

たとえば

- フォームに入力した内容が保存完了したなら、それを表示する
  - もちろん未保存を表示するのもよい
- 検索が完了するまでインジケータを表示し、検索結果がでたらインジケータの表示を消す


### ユーザーのジャーニー中の現在地を示す

ユーザに「このあとなにをするか」が示唆できてるとよい

たとえば

- パンくずリスト
- フォーム入力があとどれくらい残っているかを表示する
- 次に(起こる/操作する)ことを明示的に書いておく


### 必須でないジャーニーはスキップ可能にする

- チュートリアルをスキップ可能にする
- 前回の注文と同じものをすぐ選べるようにする


## 066 Eコマース

Eコマースは長い歴史がある。お約束を守った方がいい

- 既存のやりかたと用語(商品ページ, カート, 支払い手続き)を必ず使う
- 迷ったら他のサイトと同様に実装されているのがユーザには一番ラク


## 067 既存のレコードを複製

「既存のレコードを複製」という機能はすごい有用


## 068 `必須`, `容易`, `可能`

機能は `必須`, `容易`, `可能` に分ける  

たとえばカメラアプリだと

- `必須` シャッターのボタン
- `容易` 過去の写真を見る, フィルタの選択
- `可能` HDRの有効無効など、上級者向けのもの

お約束は以下の通り

- `必須` の機能は常に操作可能で目立つようになっている必要がある
- `可能` は隠れているべき。上級者以外の大半のユーザが使わないもの
- `容易` はそれ以外のもの

UI部品を置くときは常にどの区分かを意識した方がよい


## 069 ハンバーガーメニュー

ハンバーガーメニューはすでに悪影響が証明されているとのこと

メニューを表示するための代わりの方法はいくつかある

- iOS風: 下部にナビゲーションをつくる
- Android風: 上部にタブをつくる
- 縦にナビゲーションをつくる (Ubuntu風?)

どうしてもスペースの都合上ハンバーガーを使う場合には、それがメニューを表示するためのボタンであることを明示的にする必要がある


## 070 ページ下部のメニュー

メニュー/パンくずは下部でも再表示する  
「TOPに戻る」よりも親切な場合が多い


## 089 tabindex

input要素のtabindex属性を使う  
tabキーだけで操作できるようになる


## 092 気の利いたデフォルト

気の利いたデフォルトを用意する

たとえば `子供服 パジャマ` で検索したら、検索結果のフィルタが以下のように設定されていたら気が利いている

- ジャンル: 子供服
- 年齢:  2 - 15 才
- 在庫: アリ

ユーザのインタラクションに対してなんらか気の利いたデフォルトが用意できるとUXは大幅に向上する

- GAはログイン後のビューは**今週**のサイトの状況 ( *今日* ではない)
- iOSで通話履歴を押すと**通話**ができる (*相手の情報を表示* ではない)

ただし、何が優れたレスポンスなのかを考えるのは難しい