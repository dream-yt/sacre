---
title: "csvsqlを使ってサクッとスプレッドシートからmysqlにデータを入れる"
date: 2019-05-22T12:57:56+09:00
draft: false
---

- スプレッドシートに入れたいデータを書いてcsv形式でダウンロード
- csvをcsvsqlをつかってDBに入れる

### csvsql

csvsqlはcsvkitをインストールするとついてくる

```bash
$ pip install csvkit
```

### コマンド例

```bash
$ cat ~/Downloads/無題のスプレッドシート\ -\ シート1.csv \
  | csvsql --db mysql://root:@127.0.0.1:3306/mydb --insert --no-create --tables my_table
```

オプションなどの説明はこのへん

- [csvsql — csvkit 1.0.2 documentation](https://csvkit.readthedocs.io/en/1.0.2/scripts/csvsql.html)

### 参考

- [sql - How to let csvkit/csvsql generate insert statements for csv file? - Stack Overflow](https://stackoverflow.com/questions/36449406/how-to-let-csvkit-csvsql-generate-insert-statements-for-csv-file)
