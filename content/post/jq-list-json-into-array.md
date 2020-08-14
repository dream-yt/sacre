---
title: "jqで改行区切りなど連続したjsonを配列にする"
date: 2019-09-18T22:47:34+09:00
draft: false
author: sakamossan
---

jq でselectとかで色々やったあと配列に戻したいときがある

`jq -s` をパイプすると改行区切りのjsonを1つの配列にしてくれる

```bash
cat ./src/resources/test/ranking-latest.json \
  | jq '.[] | select(.shopId | test("^hi")) | select(.ranking <= 3)' \
  | jq -s
```


### 参考

- [jqで連続するオブジェクトを配列にする - Qiita](https://qiita.com/eielh/items/aff045e1689be8e89972)
