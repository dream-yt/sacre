---
title: "直近1週間の日付をdate形式で取得する"
date: 2019-06-03T18:01:44+09:00
draft: false
---

seqとdate(mac上で作業しているのでgnu-date)を使う

```bash
$ seq -7 0 | xargs -I{} gdate -d+{}days +'%Y-%m-%d'
2019-05-27
2019-05-28
2019-05-29
2019-05-30
2019-05-31
2019-06-01
2019-06-02
2019-06-03
```

bashのfor文とかで回す時に便利

```bash
$ for d in $(seq -7 0 | xargs -I{} gdate -d+{}days +'%Y-%m-%d'); do
>   echo mycommand --date $d
> done
mycommand --date 2019-05-27
mycommand --date 2019-05-28
mycommand --date 2019-05-29
mycommand --date 2019-05-30
mycommand --date 2019-05-31
mycommand --date 2019-06-01
mycommand --date 2019-06-02
mycommand --date 2019-06-03
```

### 参考

- [unix - How to generate a sequence of dates given starting and ending dates using AWK of BASH scripts? - Stack Overflow](https://stackoverflow.com/questions/4351282/how-to-generate-a-sequence-of-dates-given-starting-and-ending-dates-using-awk-of)
- [Macでdateコマンドが違う件について | 株式会社龍野情報システム](https://tatsuno-system.co.jp/2016/06/27/mac%E3%81%A7date%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%8C%E9%81%95%E3%81%86%E4%BB%B6%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6/)
