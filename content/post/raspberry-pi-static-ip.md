---
title: "raspberry-piに固定IPを設定する"
date: 2019-05-06T22:12:51+09:00
draft: false
---

結論としてはこんなコマンドでとりあえず固定IPを払い出せる

```bash
echo 'interface eth0' | tee -a /etc/dhcpcd.conf
echo 'static ip_address=192.168.111.90/24' | tee -a /etc/dhcpcd.conf
echo 'static routers=192.168.111.1' | tee -a /etc/dhcpcd.conf
echo 'staitc domain_name_servers=192.168.111.1' | tee -a /etc/dhcpcd.conf
```

以下、それぞれの項目についてメモ


### 設定するinterfaceの宣言

デフォルトの設定を参考にしている

```console
pi@raspberrypi:~ $ grep -A7 Example /etc/dhcpcd.conf
# Example static IP configuration:
#interface eth0
#static ip_address=192.168.0.10/24
#static ip6_address=fd51:42f8:caae:d92e::ff/64
#static routers=192.168.0.1
#static domain_name_servers=192.168.0.1 8.8.8.8 fd51:42f8:caae:d92e::1

# It is possible to fall back to a static IP if DHCP fails:
```

> interface eth0


### 払い出す固定IPアドレスの設定

- DHCPに使われない範囲のIPアドレスを使う
- ルータの設定を見たりする必要あるかも

> static ip_address=192.168.111.90/24


### ルータのIPの設定

- ipコマンドで確認
- `default via 192.168.111.1` の部分がルータのIP

```console
pi@raspberrypi:~ $ ip route
default via 192.168.111.1 dev eth0 src 192.168.111.116 metric 202
192.168.111.0/24 dev eth0 proto kernel scope link src 192.168.111.116 metric 202
```

> static routers=192.168.111.1


### DNSサーバの設定

routersと同じIPを使う

> staitc domain_name_servers=192.168.111.1



## [解決済み] DNSの設定が変?

最初、`staitc domain_name_servers=8.8.8.8` という設定をしたところ、名前解決がうまくいかなくなっていた

```
pi@raspberrypi:~ $ curl google.com
curl: (6) Could not resolve host: google.com
```

- domain_name_serversの設定がよくなくて `/etc/resolv.conf` がダメになったのかもしれない
- 以下のトラブルシュートでなんとかなった
  - [linux - curl: (6) Could not resolve host: google.com; Name or service not known - Stack Overflow](https://stackoverflow.com/questions/24967855/curl-6-could-not-resolve-host-google-com-name-or-service-not-known)


## 参考

- [ip routeコマンドの出力結果の意味 - Qiita](https://qiita.com/testnin2/items/7490ff01a4fe1c7ad61f)
