---
title: "m3u8とhls"
date: 2019-12-24T19:08:10+09:00
draft: false
---

m3u8とhls は両方とも動画ファイルの配信で使う仕様/ファイルフォーマットの名前


## m3u8 とは

動画ファイルが分割されてアップロードされている場合に、それらのインデックスとなる情報を保持するのがm3uファイル

> M3U はマルチメディアプレイリストのファイルフォーマット。Windows Media Player、iTunes、Winamp、foobar2000、ビデオ、JuKなど多くのアプリケーションがサポートしているが、正式な仕様は存在せず対応状況はまちまちである。

> M3Uファイルは、一つ、または複数のメディアファイルのパスをプレーンテキスト（テキストファイル)で記述したものである。このファイルを、".m3u"または".m3u8"の拡張子で保存する。 M3UファイルのエンコードはWindows-1252の場合が多いものの、CP932に対応しているものも存在する。エンコードがUTF-8であることを明示するとき、拡張子M3U8を使用する。

- [M3U - Wikipedia](https://ja.wikipedia.org/wiki/M3U)

utf8で書かれたm3uファイルはm3u8と呼ばれる


## m3u8ファイルの中身

こんな感じ

```ini
#EXTM3U
#EXT-X-PLAYLIST-TYPE:VOD
#EXT-X-TARGETDURATION:10
#EXTINF:10,
index-00001.ts
#EXTINF:10,
index-00002.ts
#EXTINF:10,
index-00003.ts
#ZEN-TOTAL-DURATION:30.02999
#ZEN-AVERAGE-BANDWIDTH:1364980
#ZEN-MAXIMUM-BANDWIDTH:1688541
#EXT-X-ENDLIST

```

## HLS

appleが提唱しているHLS(HTTP Live Streaming) はm3u8がもとになっている

> iOSのHTTP Live Streamingフォーマットは"M3U" and "M3U8" ファイルをもとにしている。

- 動画ファイルの圧縮形式はmpeg2-tsを使う
- 映像コーデックはh.264, 音声にはAAC


### 参考: HLSとは

- [HLSとは - Qiita](https://qiita.com/STomohiko/items/eb223a9cb6325d7d42d9)
- [Working with HTTP Live Streaming](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MediaPlaybackGuide/Contents/Resources/en.lproj/HTTPLiveStreaming/HTTPLiveStreaming.html)


## Master Playlist

(ビットレートの違いなど) 動画ファイルのvariantを指示するファイルフォーマット

- [Creating a Master Playlist | Apple Developer Documentation](https://developer.apple.com/documentation/http_live_streaming/example_playlists_for_http_live_streaming/creating_a_master_playlist)

たとえばビットレートが高い動画と低い動画のそれぞれのURLを端末に支持することができる (どちらのファイルを使うかは端末側で制御する)
