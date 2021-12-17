---
title: "capture-website-cli を使って redash のスクリーンショットを撮る  📸"
slug: redash-screenshot-with-capture-website-cli
date: 2021-12-17T18:25:13+09:00
draft: false
author: sakamossan
---

Hosted Redash が EOL になってしまった。

- [Hosted Redash End of Life](https://redash.io/help/faq/eol)

それはしょうがないのだが、グラフのスクリーンショットのPNGが返ってくるエンドポイントがセルフホストの Redash にはなくなってしまっていて、それの代替を探さないと不便だった。

puppeteer を使ってスクリーンショットをとってくれるツールをみつけたので試してみる。

- [sindresorhus/capture-website-cli: Capture screenshots of websites from the command-line](https://github.com/sindresorhus/capture-website-cli)

なかなか気の利いたオプションが渡せるので、とりあえず同等の画像を取得してくれるような設定を書いてみた。

```bash
export URL='https://redash.....api_key=xxxxxx'
npx capture-website "$URL" \
    --output=$HOME/Desktop/screenshot.png \
    --scale-factor=1 \
    --width=800 \
    --height=500 \
    --debug \
    --overwrite \
    --remove-elements='.modebar' \
    --remove-elements='.hidden-print' \
    --remove-elements='.btn-group'
```

オプションは↑で、本家でやってることと大体一緒になっている。

- [getredash/snap: Microservice to take snapshots (images/PDF) of Redash visualizations and dashboards.](https://github.com/getredash/snap/blob/master/snap-reference/src/hide-elements.js)

けっこうちゃんと撮れる。

![image](https://user-images.githubusercontent.com/5309672/146524725-067e1c24-1e33-47a6-bff0-8a8f52a9bbee.png)
