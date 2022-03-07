---
title: "ネットワークの調子が悪い時、問題を切り分けるための ping の使い方"
slug: trouble-shooting-network-with-ping
date: 2022-03-04T14:14:50+09:00
draft: false
author: sakamossan
---

まずは本当にネットワークの調子が悪いのか(UIなどのせいではないのか)、適当なリモートホストに ping 

```bash
$ ping -c 32 8.8.8.8
--- 8.8.8.8 ping statistics ---
32 packets transmitted, 32 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 6.255/187.958/1937.966/389.216 ms
```

平均して400ms弱はたしかにネットワークが遅そうである。

つぎに `localhost` に対して ping

```bash
$ ping -c 32 localhost
--- localhost ping statistics ---
32 packets transmitted, 32 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 0.027/0.059/0.125/0.021 ms
```

localhost には問題がなさそうだった。次はデフォルトゲートウェイ(家の Google Nest Wifi)に対して ping

PCのWifiの調子が悪かったりする場合はここで問題を切り分けられる。

```bash
$ route -n get 0.0.0.0 | grep gateway
    gateway: 192.168.86.1
$ ping 192.168.86.1
--- 192.168.86.1 ping statistics ---
32 packets transmitted, 32 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 1.383/140.177/745.062/201.180 ms
```

ルーターとの通信なのに平均で200ミリ秒ほどかかっていて怪しい。

ためしに iPhone でテザリングして iPhone に ping してみる。

```
$ route -n get 0.0.0.0 | grep gateway
    gateway: 172.20.10.1
$ ping -c 32 172.20.10.1
--- 172.20.10.1 ping statistics ---
32 packets transmitted, 32 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 3.934/15.736/41.888/8.589 ms
```

ルーター(GoogleNestWifi)よりも全然 iPhone のテザリングの方が安定している。

ルーターを再起動してみることにした。


## 参考

- [―分かっているようでホントは知らない―実践！ ネットワーク・トラブルシューティング：ネットワーク運用管理入門（4） - ＠IT](https://atmarkit.itmedia.co.jp/ait/articles/0402/17/news065.html)
- [Macでデフォルトゲートウェイの確認方法 | 日々修行](https://ytsuboi.jp/archives/182)
