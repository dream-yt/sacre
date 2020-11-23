---
title: "ffmpegを使ってmp3をカットする"
slug: ffmpeg-cutout-mp3
date: 2020-09-12T19:22:56+09:00
draft: false
author: sakamossan
---

こんな感じで切り出せる

```
ffmpeg -ss 7 -to 00:00:12 -i ./source.mp3 ./output.mp3
```

- `-ss`
    - 切り出す開始時点の秒数
- `-to`
    - 切り出す終了時点。ffmpegは秒数で指定するとわかりにくいのでこの形式
- `-i`
    - 元のファイル
- `./output.mp3`
    - 出力ファイル
    - ffmpegは拡張子をみて出力する形式を決める


## 参考

- [ffmpeg で指定時間でカットするまとめ | ニコラボ](https://nico-lab.net/cutting_ffmpeg/)
