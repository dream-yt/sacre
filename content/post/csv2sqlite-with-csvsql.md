---
title: "csvからsqliteのdbファイルを作成/操作"
date: 2019-05-25T13:44:24+09:00
draft: false
---

例えばathenaのクエリ結果のcsvをさらにこねたいときなど

### sqliteファイルを生成

```bash
$ csvsql \
    --db sqlite:////tmp/_.db \
    --tables t \
    --insert ~/Downloads/3a032f51-1111-411b-8e6a-d19b2beba27e.csv
$ sqlite3 /tmp/_.db '.schema'
```

### 出力

markdown形式で出したりとかなら csvlook をかませるとよい

```bash
$ sqlite3 /tmp/_.db -header -csv \
    'select user_id, SUM(_col4) from t group by user_id;' | csvlook
```

### その他

macOSの場合だとsqliteをいじるときは `db-browser-for-sqlite` が便利だった
データの更新とか表形式でいじれた方がラク

```bash
$ brew cask install db-browser-for-sqlite
$ open -a'/Applications/DB Browser for SQLite.app' /tmp/_.db
```

- [DB Browser for SQLite](https://sqlitebrowser.org/)
