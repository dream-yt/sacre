---
title: "Raspberry-Piのヘッドレスセットアップsshまで"
date: 2019-05-06T20:57:43+09:00
draft: false
---

### OSのイメージをダウンロード

こちらから (Raspbianはどの機種のraspberry-piでも動くのかな)

- [Download Raspbian for Raspberry Pi](https://www.raspberrypi.org/downloads/raspbian/)


### SDカードを初期化

Disk Utility.app を起動して目当ての外部ストレージを初期化

- 外部ストレージを選択して消去
- フォーマットはMS-DOS FAT

### OSのイメージを書き込み

```bash
$ sudo dd \
  if=~/Downloads/2019-04-08-raspbian-stretch-lite.img \
  of=/dev/rdisk2 \
  bs=1m
```

しばらく待つとできあがる

```
1720+0 records in
1720+0 records out
1803550720 bytes transferred in 160.982231 secs (11203415 bytes/sec)
```


### 起動時のsshを有効化する設定

(mac上からでも)ディレクトリを作っておくと有効になるそうだ

```
$ mkdir /Volumes/boot/ssh
```

### IPアドレスを確認

```console
$ ping raspberrypi.local
PING raspberrypi.local (192.168.111.116): 56 data bytes
64 bytes from 192.168.111.116: icmp_seq=0 ttl=64 time=1.213 ms
64 bytes from 192.168.111.116: icmp_seq=1 ttl=64 time=1.045 ms
```

### sshログイン

pingで調べたIPアドレスへssh

デフォルトでは

- ユーザ名は `pi`
- パスワードは `raspberry`

```console
$ ssh pi@192.168.111.116
The authenticity of host '192.168.111.116 (192.168.111.116)' can't be established.
ECDSA key fingerprint is SHA256:tPzfOAbGS3F7PMuA59abZcoJAiWJHkKw7b5rwBkc.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.111.116' (ECDSA) to the list of known hosts.
pi@192.168.111.116's password:
Linux raspberrypi 4.14.98+ #1200 Tue Feb 12 20:11:02 GMT 2019 armv6l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.

SSH is enabled and the default password for the 'pi' user has not been changed.
This is a security risk - please login as the 'pi' user and type 'passwd' to set a new password.

```


# 参考

- [Raspberry Pi - 初期設定、SSHログイン | UKey's Labo](https://www.ukeyslabo.com/raspberry-pi/init-and-ssh/)
- [Raspberry Pi 3 コンソールのみ(ヘッドレス)でRaspbianセットアップからLチカまで - Qiita](https://qiita.com/petersheep/items/400dce8099b4bc24245e)
