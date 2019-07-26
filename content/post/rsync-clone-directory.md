---
title: "rsyncでディレクトリをコピーする"
date: 2019-07-26T09:34:34+09:00
draft: false
---

送信元ディレクトリと送信先ディレクトリを同じ状態にしたいときは下記のような指定をする

```bash
$ rsync \
    -e "ssh -i ~/.ssh/id_rsa" \
    -ahv --compress --delete ./webui/public/ admin@test.jp:/www/data/
```

- ssh鍵が指定が必要な場合は`-e`オプションで接続の仕方を指定する
- 送信元のディレクトリは最後に`/`をつける
- 送信先はディレクトリは`/`つけない
- `--dry-run`もつけてからだと安心

## オプション

### `-a`

諸々有用なオプションが全部入りのアーカイブモードになる

>  -a, --archive               archive mode; equals -rlptgoD (no -H,-A,-X)

### `-h`

>  -h, --human-readable        output numbers in a human-readable format

### `-v`

>  -v, --verbose               increase verbosity

## 参考

- [rsyncオプション - Qiita](http://qiita.com/bezeklik/items/22e791df7187958d76c1)
- [rsync + sshで鍵ファイル認証でリモートサーバに転送する方法 · DQNEO起業日記](http://dqn.sakusakutto.jp/2011/03/rsync-ssh.html)
