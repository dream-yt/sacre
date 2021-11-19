---
title: "MacOS の du コマンドで iCloud Drive を掃除する"
slug: macos-cleanup-iclouddrive
date: 2021-11-19T12:19:27+09:00
draft: false
author: sakamyuser
---

iCloud Drive は無料で5GBまで使えるが、それを超えるとサブスクリプションが必要になる。
つねに更新されていて同期が必要になるファイルはそんなに多くないし、テキストファイルとか容量が小さいファイルばかりなので、定期的に掃除をしていれば5GBの容量で十分かなと思う。

5GBに近づくとmacOSから警告が出るが、どのディレクトリ、どのファイルが容量を食っているかを手動で調べるのはなかなか辛いのでCLIで調べることにする。


## コマンド

こんなコマンドでiCloudドライブ配下のディレクトリが、容量が多い順で表示できる。

```bash
$ du -m -d 2 ~/iCloudDrive/ | sort -nr | head -30
```

```
2255	/Users/myuser/iCloudDrive/
1335	/Users/myuser/iCloudDrive//pdf
420	    /Users/myuser/iCloudDrive//MyMusic
383	    /Users/myuser/iCloudDrive/,
370	    /Users/myuser/iCloudDrive//,/mysqldump
...
```

なお、iCloudドライブには以下のコマンドでsymlinkを作っている。

```bash
$ ln -s "~/Library/Mobile Documents/com~apple~CloudDocs" ~/iCloudDrive
```

## オプション

duコマンドのオプションはこれをつかっている

- `-m` 
    - 容量をメガバイト単位で表示する
    - 出力を sort コマンドでソートするので単位を揃える必要がある
- `-d 2` 
    - ディレクトリの深さを2階層まで探索する
    - だいたいどのディレクトリが重いのかわかったら、さらにそのディレクトリを調べる


## 参考

- [iCloudドライブを使うようになった](https://blog.n-t.jp/tech/i-use-iclouddrive/)
- [Macで容量の大きなフォルダをduコマンドで確認する - Qiita](https://qiita.com/twipg/items/4cf763aa0a09ca1e387f)

