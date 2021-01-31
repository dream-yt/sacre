---
title: "sitemap.xmlをダンプする"
slug: dump-sitemap-xml
date: 2021-01-30T17:19:15+09:00
draft: false
author: sakamossan
---

あるサイト配下のページを全部一覧したいときはsitemap.xmlを参照することになるが、sitemapがツリー構造になってたり、マイナーな場所にxmlファイルが配置されてたりとやっかいなこともある。そういうときはライブラリに頼ってしまうと手っ取り早い。

sitemap.xmlを抜いてくるのにはこれを使えばよい。

- [mediacloud/ultimate-sitemap-parser: Ultimate Website Sitemap Parser](https://github.com/mediacloud/ultimate-sitemap-parser)

抜いてきた情報を保存するのにはtinydbが便利。

- [Welcome to TinyDB! — TinyDB 4.3.0 documentation](https://tinydb.readthedocs.io/en/latest/)

```python
#!/usr/bin/env python
from tinydb import TinyDB
from usp.tree import sitemap_tree_for_homepage


db = TinyDB('tinydb/sitemap.json')
table = db.table('sitemap')
tree = sitemap_tree_for_homepage('https://example.com/')
li = []
for idx, page in enumerate(tree.all_pages()):
    li.append({
        "url": page.url,
        "last_modified": page.last_modified.isoformat() if page.last_modified else None,
        "priority": float(page.priority) if page.priority else None,
    })
    if 50000 < len(li):
        table.insert_multiple(li)
        li = []
        print(idx)
```


## 注意点

- 数万行入れるときtinydbは `insert_multiple` を使わないとかなり遅い。
- `ultimate-sitemap-parser` は `priority` をDecimalで返してくるので、JSONにするときはfloatに丸めてしまう。
