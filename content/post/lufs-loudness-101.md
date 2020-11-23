---
title: "動画のラウドネスについて"
slug: lufs-loudness-101
date: 2019-10-08T13:08:30+09:00
draft: false
author: sakamossan
---

動画のエンコードをする場合の用語の整理    
映像系の人が出してくる仕様で知らない用語があったのでメモ


### 参考にしたもの

このドキュメントが(比較的)平易だった

- [オーディオコンテンツのラウドネス値の正規化 | Alexa Skills Kit](https://developer.amazon.com/ja/docs/flashbriefing/normalizing-the-loudness-of-audio-content.html)


## ラウドネス

> ラウドネスメーターと呼ばれるツールを使用して、音声のラウドネスを正規化します。ラウドネスメーターは、音声をラウドネス単位（LU）で測定します。ラウドネスメーターはピークメーターや波形メーターとは異なり、音声の電圧レベルを測定するのではなく、人間が耳で聞いた音をどのように感じるかを測定します。

ラウドネスの中でも2つ一般的な指標がある


### LUFS (LKFS)

音声全体がどれくらいの音圧かを指標化したもの

- LUFSとLKFSは同じもので規格によって呼び方が違う
- LUFS = Loudness Unit Full Scale



### dBTP

- デジタル音声はアナログ音声をサンプリングしたものである
- サンプリングされたときに信号のピーク値が失われる

![image](https://user-images.githubusercontent.com/5309672/66366718-5890de00-e9cc-11e9-9fe5-03e59c670f3d.png)

引用元: [インターサンプルピーク/トゥルーピークの復習をして、Ceiling設定について考える | SOUNDEVOTEE.NET](https://soundevotee.net/blog/2018/03/09/learn_about_isp_and_think_about_ceiling/)

このとき、サンプリング前のピーク値を推測した値がトゥルーピーク
これがわかっていないとハードウェアの制約で音が歪んでしまう場合がある


##### ダイナミックレンジ

dB のこと。おおまかに音量

音はハードウェアの制約で大きすぎても小さすぎても音声を正しく表現できない

- 小さすぎる音はハードウェアのノイズに埋もれてしまって正しく表現されない
- 大きすぎる音は出力が歪んでしまって正しく表現されない

