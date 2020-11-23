---
title: "circleci上でjest-watch-typeaheadがロードできずエラーになる場合"
slug: jest-watchPlugins-circleci-error
date: 2019-04-27T12:38:51+09:00
draft: false
author: sakamossan
---

## 前提

以下の場合だと(たぶん) circleci上でテストをするとき問題になる

- create-react-app で作業している
- yarn reject 済み

### こんなエラー

circleci上でこんな感じにてテストが落ちる

```bash
#!/bin/bash -eo pipefail
cd ./functions/viewer/client && \
$(npm bin)/jest
● Validation Error:

  Module /Users/sakamossan/.ghq/github.com/functions/viewer/client/node_modules/jest-watch-typeahead/filename.js in the watchPlugins option was not found.
         <rootDir> is: /home/circleci/project/functions/viewer/client

  Configuration Documentation:
  https://jestjs.io/docs/configuration.html
```


## 問題

- package.jsonのjest.watchPluginsの設定が絶対パスになっている
- jestの設定は `<rootDir>` という変数みたいなのが使えるが、watchPluginsではこれが使えない
- ローカルでは絶対パスで正しいが、circleci上ではそれだとダメ


## 対応

watchPluginsはパスを探すときnode_modules配下を探してくれるので、
node_modules配下の相対パスを記述すれば読んでくれた

```json
{
  "jest": {
    "watchPlugins": [
      "jest-watch-typeahead/filename",
      "jest-watch-typeahead/testname"
    ]
  }
}
```

これはもともとのドキュメントにも書いてある書き方

- [jest-community/jest-watch-typeahead: Jest watch plugin for filtering test by file name or test name](https://github.com/jest-community/jest-watch-typeahead#add-it-to-your-jest-config)


### 所感

create-react-app/reject のあれがちょっとアレでしたね、というところ
