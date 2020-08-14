---
title: "ffmpegコマンドの最小限の基本"
date: 2019-10-23T17:45:08+09:00
draft: false
author: sakamossan
---

基本はこの順番

```
ffmpeg -i {{ 入力ファイル }} {{ フィルタ }} {{ 出力ファイル }}
```

### フィルタとは

- 動画、音声、または両方を加工するためのもの
- たとえばぼやかしたり、前後にフェードインフェードアウトを入れたりできる
- 一度に複数重ねてかけることもできる (フィルタチェイン)


## 動画ファイルの情報を見るだけ

一番基本的なのは動画の情報を見るだけの使い方 (とくにフィルタは使わない)

```bash
$ ffmpeg -i ~/Desktop/mp4/test.mp4 -f null -
```

- `-i`
  - 入力ファイル
- `-f`
  - 本来は出力の形式を指定するオプション
  - `-f null -`を指定すると出力ファイルを作らない挙動になる



## 参考

わかりやすい解説がたくさんある

- [ffmpeg使い方のまとめ | みんなのメモ帳](https://yoshipc.net/how-to-use-ffmpeg/)
- [それFFmpegで出来るよ！ - Qiita](https://qiita.com/cha84rakanal/items/e84fe4eb6fbe2ae13fd8)
- [なるべく理解したいffmpeg - ザリガニが見ていた...。](https://zariganitosh.hatenablog.jp/entry/20150619/understand_ffmpeg)
