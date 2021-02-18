---
title: "Redis::Fast の sentinel 引数ってなに?"
slug: pl5-redis-fast-redis-sentinel
date: 2021-02-18T16:29:10+09:00
draft: false
author: sakamossan
---

プロジェクトでこんな設定でRedisを動かしていたが、なんで動いているか分からなかった。
`Redis::Fast` のPODにはsentinelsのことは記載がない。

```perl
Redis::Fast->new(
    sentinels => ['redis-sentinel:26379']
    service => 'master'
    reconnect => 10
);
```

PODしか読んでいなかったが、PODに書いてないだけで、機能としては実装されていた。
最近はnpmパッケージと仕事をしていたので、わたくし甘やかされていました。

- [Redis::Fast - Perl binding for Redis database - metacpan.org](https://metacpan.org/pod/Redis::Fast)
- [Support for Redis Sentinel · Issue #6 · shogo82148/Redis-Fast](https://github.com/shogo82148/Redis-Fast/issues/6)

使い方の説明もこちらに書いてあった。

- [Redis::Fast 0.07 をリリースしました！](https://shogo82148.github.io/blog/2014/05/17/redis-fast-0-dot-07-released/)

> コネクションを作るときに sentinels を渡すと Redis Sentinel から接続情報を取ってきてくれます。 一緒に reconnect を設定しておいてあげると、Masterに何かあった時に接続情報を再取得→ 自動的に Slave へフェールオーバーしてくれます。

便利
