---
title: "webpackの開発用に便利なオプション"
slug: webpack-dev-options
date: 2020-02-26T18:26:57+09:00
draft: false
author: sakamossan
---

1ファイルだけトランスパイルするならこんな感じ

```bash
$ npx webpack $entry --output $output \
  --progress \
  --cache=true \
  --display-error-details \
  --debug \
  --devtool eval-cheap-module-source-map \
  --output-pathinfo \
  --watch
```

- `--progress`
  - 動作重い時でも動いているかどうかわかるだけで便利
- `--cache=true`
  - import結果をキャッシュしてくれる。すごく早くなって便利
- `--watch`
  - もちろん便利

`-d` をつけると以下のオプションが有効になる

>   -d           
> shortcut for --debug --devtool eval-cheap-module-source-map --output-pathinfo

明示的に指定した方がわかりやすいので、`-d` ではなく個別に指定した

その他、modeを適宜設定したりなどしてもよい
