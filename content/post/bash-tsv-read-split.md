---
title: "bashスクリプトに、tsvの標準入力を入れて、readで使いやすくやる"
date: 2019-10-21T15:35:05+09:00
draft: false
---

readというコマンドがあり、多くはシェルスクリプトでユーザの入力を受け取るときに使われるが、これをwhileと一緒に使うと標準入力を1行ごと変数に束縛して処理ができる

```bash
while read line; do
  echo $line;
done
```

ここまではなんとなくみたことあったが、変数を複数宣言しておくと  
空白区切りでsplitしてくれるという機能があった

- [bashで文字列分解する時、cutやawkもいいけど、setの方が早い、けどreadが最強 - Qiita](https://qiita.com/hasegit/items/5be056d67347e1553f08#read%E3%81%AE%E5%A0%B4%E5%90%88)

### つまり

こんなスクリプトを用意して

```bash
while read key value; do
  echo "key:${key}, value:${value}"
done
```

tsvを標準出力から入れると

```txt
isom ~/Desktop/mp4/1021/ehara.mp4
isom ~/Desktop/mp4/1021/uno.mp4
mp42 ~/Desktop/mp4/1021/megurizumu.mp4
```

1カラム目が `$key` 2カラム目が `$value` に束縛できる

```console
$ pbpaste > /tmp/read-split.sh  # スクリプトをファイルに
$ pbpaste | bash /tmp/read-split.sh  # csvをコピーして実行
key: isom, value: ~/Desktop/mp4/1021/ehara.mp4
key: isom, value: ~/Desktop/mp4/1021/uno.mp4
key: mp42, value: ~/Desktop/mp4/1021/megurizumu.mp4
```

---

いままでtsvになったらperlで処理してたけど、bashで済む場合に楽が出来そう  
とくにcurlとかhttpリクエスト必要な処理
