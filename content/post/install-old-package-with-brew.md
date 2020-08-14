---
title: "homebrewで過去のversionをインストールする"
date: 2019-04-04T15:22:47+09:00
draft: false
author: sakamossan
---


- Formulaが入ってるディレクトリに行く
    - `cd /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/`
- 目当てのバージョンでコミットされてるハッシュを見る
    - `$ git log foo.rb`
- そのファイルを巻き戻す
    - `$ git checkout fd1dxxxx foo.rb`
- 入れ直す
    - `$ brew reinstall foo.rb`

