---
title: "PythonでTimezone Aware(Jst)なdatetimeを作る"
date: 2019-01-12T23:42:03+09:00
draft: false
author: sakamossan
---

ググっても簡単なのが出てこなかったのでメモ

環境は python 3.6.7

こんな定義で引数に渡した日付時間がJSTのdatetimeになる

```python
from pytz import timezone

def jst_datetime(*args):
    rest = [0] * (7 - len(args))
    return datetime(*args, *rest, timezone('Asia/Tokyo'))
```

#### 使い方

datetimeと同じ

```python
got = jst_datetime(2019, 1, 5, 2, 0)
t.assertIs(got.hour, 2)
t.assertIs(got.day, 5)
t.assertEqual(str(got.tzinfo), 'Asia/Tokyo')

got2 = jst_datetime(2019, 1, 5, 2)
t.assertEqual(got, got2)
got3 = jst_datetime(2019, 1, 5, 2, 0, 0)
t.assertEqual(got, got3)
```

### 参考

- [8.1. datetime — 基本的な日付型および時間型 — Python 3.6.5 ドキュメント](https://docs.python.jp/3/library/datetime.html)
