---
title: "HLSとm3u8ファイルとMaster Playlistについて"
date: 2020-01-06T12:33:01+09:00
draft: false
---

こちらの記事の焼き直し

- [m3u8とhls · sacre](https://dream-yt.github.io/post/m3u8andhls/)


## m3u8ファイルとは

こちらがわかりやすかった

- [動画配信技術 その1 - HTTP Live Streaming(HLS) - Akamai Japan Blog](https://blogs.akamai.com/jp/2013/02/-1---http-live-streaminghls.html)

HLSを行うためのヘッダファイルのようなもの
HLSでは動画をtsファイルという秒単位の細かいファイルへと細切れにして配信を行う
m3u8ファイルには、細切れの動画ファイルがそれぞれ何秒から何秒までのデータを保持しているかがまとまっている

ライブ配信の場合にはm3u8ファイルが数秒ごとに更新されるとのこと

- [ライブ動画配信プロトコル（HTTP Live Streaming, HLS）の概要図解メモ（AbemaTV／FRESH!）](https://did2memo.net/2017/02/20/http-live-streaming/)

#### m3u8形式ファイルの例

`EXTINF:10` というのが動画の秒数を表している

```
#EXTM3U
#EXT-X-PLAYLIST-TYPE:VOD
#EXT-X-TARGETDURATION:10
#EXTINF:10,
file-640-00001.ts
#EXTINF:10,
file-640-00002.ts
#EXTINF:10,
file-640-00003.ts
#ZEN-TOTAL-DURATION:30.02999
#ZEN-AVERAGE-BANDWIDTH:1147001
#ZEN-MAXIMUM-BANDWIDTH:1340365
#EXT-X-ENDLIST
```


## Master Playlist とは

MasterPlaylistファイルは複数のm3u8ファイルをまとめるインデックスファイルのような役割をもっている
MasterPlaylistファイルを使うと、通信速度や処理できるファイル形式/ビットレートごとに、
どのm3u8ファイルを参照して動画を再生すればよいかをクライアントデバイスが判断できるようになる

- [Creating a Master Playlist | Apple Developer Documentation](https://developer.apple.com/documentation/http_live_streaming/example_playlists_for_http_live_streaming/creating_a_master_playlist)

#### MasterPlaylist形式の例

```
#EXTM3U
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1040000,CODECS="mp4a.40.2, avc1.4d4015"
file-640.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=640000,CODECS="mp4a.40.2, avc1.4d4015"
file-640.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=440000,CODECS="mp4a.40.2, avc1.4d4015"
file-640.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=240000,CODECS="mp4a.40.2, avc1.4d4015"
file-640.m3u8
```
