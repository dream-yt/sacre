---
title: "macで動画のビットレートを変更したい"
date: 2019-02-13T15:20:54+09:00
draft: false
author: sakamossan
---

ffmpegを使う

```bash
$ brew install ffmpeg
```

こんな感じで使う

```bash
$ ffmpeg -i ./inputfile.mp4 -b:v 2M -bufsize 10M ./outfile.mp4
```

- `-b:v 2M`
    - 指定したいbitrate。KBで指定したい場合は `320K` のようにKを使う
- `-bufsize 10M`
    - どれくらいの領域を使ってbitrateを計算するか
    - これが大きいと指定した値に近いbitrateで動画が出来上がる

bufsizeを指定しないと指定した通りのbitrateにならなかったのでbufsize指定した方がよさそう

### ffprobe

ffmpegを入れるとffprobeというコマンドも使えるようになる

これは動画の詳細な情報を見るのに便利

```console
$ ffprobe ./outfile.mp4 -hide_banner
Input #0, mov,mp4,m4a,3gp,3g2,mj2, from './outfile.mp4':
  Metadata:
    major_brand     : isom
    minor_version   : 512
    compatible_brands: isomiso2avc1mp41
    encoder         : Lavf58.12.100
  Duration: 00:00:15.08, start: 0.000000, bitrate: 1672 kb/s
    Stream #0:0(und): Video: h264 (High) (avc1 / 0x31637661), yuv420p, 1280x720 [SAR 1:1 DAR 16:9], 1538 kb/s, 23.98 fps, 23.98 tbr, 24k tbn, 47.95 tbc (default)
    Metadata:
      handler_name    : VideoHandler
    Stream #0:1(jpn): Audio: aac (LC) (mp4a / 0x6134706D), 48000 Hz, stereo, fltp, 130 kb/s (default)
    Metadata:
      handler_name    : SoundHandler
```

- `-hide_banner`
    - デフォルトだとライセンスの表示などが出力されるのでそれの抑制

### 参考

- [Limiting the output bitrate – FFmpeg](https://trac.ffmpeg.org/wiki/Limiting%20the%20output%20bitrate)
