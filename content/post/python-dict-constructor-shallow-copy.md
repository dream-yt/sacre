---
title: "pythonで辞書をdict()したときの値のコピーのされかたがshallow-copyなのを確認"
slug: python-dict-constructor-shallow-copy
date: 2020-11-16T19:14:09+09:00
draft: false
author: sakamossan
---

pythonで `dict()` を呼ぶとdict-likeな値をdictにキャストできる。
もとの辞書の値がコピーされているのだが、shallow copyなのかどうなのかを確認した。

```python
d1 = {1: 2, 3: {4: 5}}
d2 = dict(d1)
assert d1 == d2  # 等価

d1[1] = 'a'        # 元のdictの値を変更しても
assert d2[1] == 2  # コピーされたdictの値は変わらない

d1[3][4] = 'a'          # 深いところの値を変更すると
assert d2[3][4] == 'a'  # shallow-copyなのでdictこっちの値は変わってしまう
```