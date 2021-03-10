---
title: "つくられてから1時間以上経った未圧縮のファイルだけを削除する"
slug: find-and-delete-compressed-file-60min-ago
date: 2021-03-10T15:38:49+09:00
draft: false
author: sakamossan
---

こんなことをしたい場合

- 最終更新が60分前になっているファイル
- 名前が"\*.zst"という**形式ではない**ファイル (未圧縮)
- それらに対して `/usr/local/bin/zstd --rm` を実行する

```bash
/usr/bin/find /path/to/files \
  -type f \
  -mmin +60 \
  ! -name "*.zst" \
  -exec /usr/local/bin/zstd --rm {} \; \
```

#### オプション

- `-type f` 
    - ディレクトリでなくファイルだけを対象にする
- `-mmin +60` 
    - 最後に内容が変わったのが60分以上過去のファイルを対象とする
- `! -name "*.zst"` 
    - 名前が `*.zst` **でない**ファイルを対象とする
- `-exec /usr/local/bin/zstd --rm {}`
    - それらのファイルに `zstd --rm` を実行する
    - 実行時には `{}` がファイル名に置き換わる


### cron

cronするなら `/bin/bash -c` とすると手っ取り早い

```bash
*/10 * * * * appuser /bin/bash -c '\
  /usr/bin/find /path/to/files \
    -type f \
    -mmin +60 \
    ! -name "*.zst" \
    -exec /usr/local/bin/zstd --rm {} \; \
'
```

## 参考

- [findコマンドのmtimeオプションまとめ - Qiita](https://qiita.com/narumi_/items/9ea27362a1eb502e2dbc)
