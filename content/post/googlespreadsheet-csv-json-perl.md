---
title: "GoogleSpreadsheetのデータ(csv)をパパッとjsonにしてスクリプトから使う"
date: 2018-11-03T17:24:38+09:00
draft: false
---


csvjsonを使うとcsv => json が簡単に変換できる
csvjsonはcsvkitをインストールすると入ってくる

```console
$ brew install csvkit
...
$ which csvjson
/usr/local/bin/csvjson
```

### csvでダウンロード

Google SpreadSheetからcsv形式でダウンロード

- ファイル
    - 形式を指定してダウンロード
        - カンマ区切りの値

![image](https://user-images.githubusercontent.com/5309672/47705130-f7fc0b80-dc68-11e8-90c9-1a92ea1b3a1f.png)

csvjsonはデフォルトだとa, b といったキー名のオブジェクトを配列で作ってくれる

```console
$ cat ~/Downloads/テストのデータ\ -\ シート1\ \(1\).csv | csvjson -H | jq .
[
  {
    "a": null,
    "b": "TOKIO",
    "c": 1
  },
  {
    "a": null,
    "b": "SMAP",
    "c": 2
  },
  {
    "a": null,
    "b": "嵐",
    "c": 0
  }
]
```


### スクリプト

あとはjsonをスクリプトで使う  
perlだとjsonのdecodeはこんな感じ

```
#!/usr/bin/perl
use JSON qw'decode_json';
my $input = decode_json join("", <STDIN>);
print "group arrested counts: " map {$_->{c}} @$input;
```

パイプで繋げばスプレッドシートのデータをスクリプトで操作できる

```bash
$ cat ~/Downloads/テストのデータシート1.csv | csvjson -H | ./myscript.pl
```

##### `-H`

```console
$ csvjson --help | grep '\-H'
  -H, --no-header-row   Specify that the input CSV file has no header row.
```


### もうちょっとインタラクティブに

スプレッドシートの権限をゆるくすればcurlでcsvを取ったりも出来る

- [publish to web in csv in google sheets - Google プロダクト フォーラム](https://productforums.google.com/forum/#!topic/docs/An-nZtjaupU)

```bash
$ curl -s https://docs.google.com/spreadsheets/d/xxxxxxx/export?format=csv \
    | csvjson -H | ./myscript.pl
```
