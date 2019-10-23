---
title: "watchで出力が変化したら通知が欲しい"
date: 2019-10-23T15:25:01+09:00
draft: false
---

watchコマンドにはエラー時にビープするオプションはあるが、コマンドが正常終了した場合にビープして気がつく手段がないのでそれをなんとかする

- [mac/iterm2の設定](#maciterm2の設定)
- [watch側のコマンド](#watch側のコマンド)
    - [`--chgexit`](#--chgexit)
    - [`--interval 60`](#--interval-60)
    - [`perl -E 'say "\007"'`](#perl--e-say-\007)
- [動作確認](#動作確認)


## mac/iterm2の設定

通知の設定をONにしておく

- Profile 
  - Terminal 
    - Notification Center

![貼り付けた画像_2019_10_23_15_14](https://user-images.githubusercontent.com/5309672/67363240-e4e3f900-f5a7-11e9-8823-11bbccb3d3d9.png)


## watch側のコマンド

60ごとにコマンドを実行して結果を監視したい場合はこんな感じ

```
$ watch --chgexit --interval 60 {{ コマンド }} && perl -E 'say "\007"'
```

#### `--chgexit`

出力が変化したらwatchコマンドを終了する


#### `--interval 60`

60ごとにコマンドを実行する


#### `perl -E 'say "\007"'`

macでビープ音を出すためのコマンド  
好みでsayなどを使ってもよい


## 動作確認

macのitermで beep/chgexit がどんな感じになるか確認する

watchでlsファイルさせて、途中でみてるファイルに書き込みを行う

```bash
$ watch --chgexit --interval 4 "ls -laGh /tmp/_" && perl -E 'say "\007"'
```

```bash
$ echo "hello" >> /tmp/_
```

こんな感じで通知が得られる

![image](https://user-images.githubusercontent.com/5309672/67362812-e3fe9780-f5a6-11e9-8de8-3dca447cd663.png)
