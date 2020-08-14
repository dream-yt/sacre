---
title: "mp4dumpでmp4ファイルのメタデータ(atom)をJSONで取得する"
date: 2020-08-12T18:34:01+09:00
draft: false
author: sakamossan
---

mp4dumpを使うとJSON形式で取得できる

```bash
$ mp4dump ./test.mp4 --format json > /tmp/_
```

```json
$ mp4dump ./test.mp4 --format json | jq . | head -30
[
  {
    "name": "ftyp",
    "header_size": 8,
    "size": 28,
    "major_brand": "mp42",
    "minor_version": 0,
    "compatible_brand": "avc1"
  },
  {
    "name": "moov",
    "header_size": 8,
    "size": 9187,
    "children": [
      {
        "name": "mvhd",
        "header_size": 12,
        "size": 108,
        "timescale": 10000,
        "duration": 150400,
        "duration(ms)": 15040
      },
      {
        "name": "trak",
        "header_size": 8,
        "size": 5341,
        "children": [
          {
            "name": "tkhd",
            "header_size": 12,
            
  ...
```


インストールはbrewでできる

```bash
$ brew install bento4
```

JSONをnodejsで処理するならこんな感じ

```js
#!/usr/bin/env node
const { execFileSync } = require('child_process');
const [nodeExecutable, thisScriptPath, filename] = process.argv;
const stdout = execFileSync('/usr/local/bin/mp4dump', [filename, '--format', 'json']);
const atoms = JSON.parse(stdout);
```

## 参考

- [mp4dump | Bento4](https://www.bento4.com/documentation/mp4dump/)
- [ffmpeg - How to extract MOOV atom/metadata from MP4 file? - Video Production Stack Exchange](https://video.stackexchange.com/questions/15080/how-to-extract-moov-atom-metadata-from-mp4-file)
