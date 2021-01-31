---
title: "Python Csv Writer"
slug: python-csv-writer
date: 2021-01-30T17:32:35+09:00
draft: false
author: sakamossan
---

pythonでcsvファイルを作るときに毎回調べているのでメモ。

だいたいデータはJSONとかなはずなので `csv.DictWriter` を使いたくなるが、普通の `csv.writer` を使って2次元配列を作るやりかたのほうがオプション等々覚えることが少なくて済む。

```python
import csv

# header行は1つめに入れてしまうのがわかりやすい
li = [["id", "name", "age"]]

# ... 中略 ... リストにデータを入れる

with open('./data.csv', 'w') as f:
    # 全ての非数値フィールドをクオートする
    writer = csv.writer(f, quoting=csv.QUOTE_NONNUMERIC)
    writer.writerows(li)
```

# 参考

- [csv --- CSV ファイルの読み書き — Python 3.9.1 ドキュメント](https://docs.python.org/ja/3/library/csv.html#csv.QUOTE_NONNUMERIC)
