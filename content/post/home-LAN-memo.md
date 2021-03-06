---
title: "自宅のLANの設定で毎回調べることメモ"
slug: home-LAN-memo
date: 2019-12-11T11:55:06+09:00
draft: false
author: sakamossan
---

## PPPoE とは

- [インターネット用語1分解説～PPPoEとは～ - JPNIC](https://www.nic.ad.jp/ja/basics/terms/pppoe.html)

#### まずPPPとは

> PPPの機能の中には、 ユーザーの認証やIPアドレスの割り当て等が含まれます。

ネットワーク内で認証してIPアドレスをもらうためのプロトコル

LANの設定でもPPPを(oEで)行う

- プロバイダと契約するとIDとパスワードがもらえる
- そのIDとパスワードで認証する
- IPアドレスをもらってインターネットと通信する


#### PPPoE (PPP over Ethernet)

イーサネット上で認証してIPアドレスをもらうためのプロトコル

- まずEthernetで自宅のルーターとプロバイダが接続
- 接続できたら、PPPoEセッションでトンネルしたPPPプロトコルにて認証してIPをもらう


##### トンネルとは

> トンネルとは、ある通信プロトコルを別のプロトコルでカプセル化して通信できるようにすることで、 
>そのような通信の方式をトンネリングと呼びます。

今回の場合はPPPの通信をPPPoEセッションでカプセル化している
(id/passworkの暗号化とかはPPPoEがやってくれる)


## WAN とは

定義はこう

> Wide Area Network（ワイドエリアネットワーク）」の略で、遠く離れた場所とつながったネットワークのことで、だれもが自由に接続できるネットワークです

- [LANとWANって何が違うの？｜ネットの知恵袋｜フレッツ光公式｜NTT西日本](https://flets-w.com/user/point-otoku/knowledge/other/otherl28.html)

大体の場合LANの設定でWANという言葉が出てきた場合、  
「LANに対してインターネット側」という認識で良い
