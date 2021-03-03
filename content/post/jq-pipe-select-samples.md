---
title: "jqのselectでフィルタする"
slug: jq-pipe-select-samples
date: 2021-03-03T17:04:20+09:00
draft: false
author: sakamossan
---

selectはsqlのwhere句みたいに使う。こんな感じでつかう。

```bash
# foo配列の中のオブジェクトでbar属性が存在するものだけ表示
.foo[] | select(has('bar'))
```

- 配列の中身をリストの状態でパイプに渡す
- パイプの先では `.` がリストの1要素になっている
  - has関数には `.` 自体が引数で渡り、キーを検査されている
- select(true)なものだけ出力に出る

### 例

インスタンスのタグの配列から Key属性が `ENVIRONMENT` なオブジェクトになっているものを絞る場合

```bash
$ aws ec2 describe-instances --instance-ids i-05b2 > ./_
$ cat ./_ \
    | jq '.Reservations[0].Instances[0].Tags[] \
    | select(.Key=="ENVIRONMENT")'
```
