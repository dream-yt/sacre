---
title: "【ロゴ作成】RGBとCMYKの色マニュアルを作った時の備忘録"
slug: logo-colormode
date: 2018-11-07T12:51:45+09:00
draft: false
author: dream-yt
---

![This is a image](/images/post/dream/LogoColorMode01.png)

## 状況
新ロゴができたので、RGBとCMYKで色のマニュアルを作る。
が。
RGBで作成したAiデータをCMYKに変換しただけでは、色が変わってしまうよね。

## 手順

### 色調整
- メインとなるデータ（今回はこっちがRGB）を複製して、別のカラーモードで保存

![This is a image](/images/post/dream/LogoColorMode02.png)

- RGBの見え方に似るようにCMYKの色を設定し直す
- 両方とも開いて並べるとやりやすい

![This is a image](/images/post/dream/LogoColorMode03.png)


### CMYKの数値チェック
- カラーウィンドウで確認してみると、大抵数値が細かい。端数はトル。

![This is a image](/images/post/dream/LogoColorMode04.png)

### 濃度オーバーに注意
例えばこんな数値だった場合。

![This is a image](/images/post/dream/LogoColorMode05.png)

- パレットの合計値を確認すると「310」
- 300を超えると裏写りが発生するため、狙いの色を300以下で再現できるように調整。（ビビりなので250で攻めたい）
- ロゴは印刷物に使われることも頻繁なので注意する

## 複数タイプのロゴがある場合
RGBとCMYKの数値が固まったので、小さいサイズ用など、複数パターンのロゴカラーも一気に変換したい。
「オブジェクトを再配色」で色を一気に置き換え。

![This is a image](/images/post/dream/LogoColorMode06.png)
![This is a image](/images/post/dream/LogoColorMode07.png)
![This is a image](/images/post/dream/LogoColorMode08.png)

できた！  
