---
title: "開発中のパッケージをrequireできる npm link を使う"
date: 2020-05-04T22:36:52+09:00
draft: false
---

npmパッケージを開発するとき、いちいちnpmにアップロードしてそれを使う側でinstallしてなどとやってられないので npm link という仕組みがある

たとえば `api-client` パッケージというのがあり、それを `service` パッケージで使いたい場合は以下のような手順になる

```bash
# api-clientのディレクトリに移動して npm link
$ cd api-clilent
$ npm link
...
```

```bash
# serviceディレクトリに移動して npm link api-clilent
$ cd service
$ npm link api-clilent
...
```

#### vscode

これだけだと vscode ではエラーになるので、 vscode を使ってる場合には package.json の依存管理の欄に `api-client: ""` などと足しておく


## 何をやっているのか

symbolic link の仕組みが使われている

- `npm link` で、まずグローバルの node_modules 配下に `api-client` へ向いている symlink が作られる
- `npm link api-client` を実行すると、グローバルの node_modules/api-client 配下を見ている symlink が service/node_modules 配下にできる


## npm unlink

貼ったシンボリックリンクを消したい場合は npm unlink で消すことができる

```bash
$ cd service
$ npm unlink api-clilent
$ cd ./../api-clilent
$ npm unlink
```


## 参考

- [npm-link | npm Documentation](https://docs.npmjs.com/cli/link.html)
- [The magic behind npm link - Alexis Hevia - Medium](https://medium.com/@alexishevia/the-magic-behind-npm-link-d94dcb3a81af)
