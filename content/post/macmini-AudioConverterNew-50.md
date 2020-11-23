---
title: "AudioConverterNew returned -50"
slug: macmini-AudioConverterNew-50
date: 2019-01-02T20:13:32+09:00
draft: false
author: sakamossan
---

> 2019-01-02 18:56:01.693434+0900 MyAPP[7575:859800] [AQ] 1154: AudioConverterNew returned -50

Mac miniでAVAudioRecorderを使おうと際にすると出るwarning

macbookなどには音声入力があるが、Mac miniには無いので、これが無いと掲題のエラーメッセージが出る。そして録音はされない。(サイズが0のファイルが生成される)

詳しくは↓のリンクにて

- https://stackoverflow.com/questions/34972436/why-do-i-get-audioconverternew-error-when-using-preparetorecord

ちなみに適当なマイクを接続するとMac miniでも問題なく動く
