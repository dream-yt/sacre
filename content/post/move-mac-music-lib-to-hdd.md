---
title: "[CLI] iTunes のライブラリを外付け HDD に zip で保存する"
slug: move-mac-music-lib-to-hdd
date: 2021-06-06T11:58:38+09:00
draft: false
author: sakamossan
---

## ライブラリの統合

iTunes のライブラリを別のコンピュータに移行するには、`iTunes Media のファイルの統合` を事前に行っておく必要がある。
これは PC のいろんなところに散逸している音楽ファイルを iTunes ディレクトリ配下で管理するオプション。

- iTunes Media のファイルを統合する
- 古い Mac から「iTunes フォルダ」を外付けドライブ（外付けハードディスクや USB ドライブなど）にコピーする
- 新しい Mac に入っている音楽ファイルをバックアップする

いちど統合が完了したライブラリは、iTunes ディレクトリを新しい PC にポン置きするだけで移行が完了する。

## 外付け HDD へ書き出し

GUI(Finder)から iTunes ディレクトリを zip しようとしたら PC の空き容量がなくてそれが無理だったので、zip の書き出し先を直接外付け HDD に指定する。

```bash
$ zip -r /Volumes/HD-PNTU3/Music/iTunes_$(date +"%F") ~/Music/iTunes
```

## 参考

- [iTunes ライブラリを別のコンピュータに移動する - Apple サポート](https://support.apple.com/ja-jp/guide/itunes/itns3230/windows)
- [【mac】zip ファイル操作コマンド - Qiita](https://qiita.com/griffin3104/items/948e38aab62bbb0d0610)
