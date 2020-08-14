---
title: "npmパッケージング関連コマンド"
date: 2019-10-20T16:49:23+09:00
draft: false
author: sakamossan
---

- [CLI documentation | npm Documentation](https://docs.npmjs.com/cli-documentation/)


## npm init

package.json を一般的な方式で初期化してくれる

- [npm-init | npm Documentation](https://docs.npmjs.com/cli/init.html)


## npm set

author 情報の更新/設定

```bash
$ npm set init.author.url https://twitter.com/sakamoto_akira_
$ npm set init.author.email mild7caloriemategreentea@gmail.com
$ npm set init.author.name sakamoto_akira_
$ npm adduser
```


## npm version 

package.json の version を上げてくれる

```bash
$ npm version patch
$ npm version minor
$ npm version major
```

- [Updating your published package version number | npm Documentation](https://docs.npmjs.com/updating-your-published-package-version-number)


## npm publish

パッケージの公開


```bash
$ git push origin tags/v"$(cat ./package.json | jq -r .version)"
$ npm publish ./
```
