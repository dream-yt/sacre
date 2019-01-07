---
title: "hostileで/etc/hostsをテキスト管理する"
date: 2019-01-07T17:24:25+09:00
draft: false
---

- [feross/hostile: Simple, programmatic `/etc/hosts` manipulation (in node.js)](https://github.com/feross/hostile)

### install

インストールはyarnで入る (brewとかは用意されてなさそう)

```bash
$ yarn global add hostile
```

### load

`hostile load` コマンドで引数に渡した定義が/etc/hostsに入ってくれる

```
sudo hostile load local-dns-records.hostile
```

`local-dns-records.hostile` の中身はこんな感じ

```bash
# コメントが書ける
127.0.0.1 localhost localunixsocket localunixsocket.local
255.255.255.255 broadcasthost
::1 localhost
```

### unload

使っていないがloadの逆のunloadも出来るようだ
(複数ファイルに分けて環境ごとに使えそう)

- [unload](https://github.com/feross/hostile#unload-remove-a-set-of-hosts-from-a-file)
