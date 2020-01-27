---
title: "herokuにデプロイ"
date: 2020-01-27T12:38:15+09:00
draft: false
---

忘れるのでメモ

```bash
$ brew install heroku
$ heroku login # あらかじめherokuのUIでアカウントをつくっておいたアカウントでログイン
$ cd ~/path/to/app # アプリをつくる
$ heroku create rsshub-yahoo-jp-tv  # 名前は一意でないとダメ
$ git push heroku $(currench):master  # 現在のブランチをherokuのmasterにpush
$ heroku open # ブラウザが開く
```

### 参考

- [Deploying with Git | Heroku Dev Center](https://devcenter.heroku.com/articles/git)
- [Herokuの基礎知識 - Qiita](https://qiita.com/daisukeoda/items/42e802c498ca8a78b8f2)


