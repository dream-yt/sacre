---
title: "RSSHubにPR出すときのメモ"
date: 2020-03-29T20:45:55+09:00
draft: false
---

- [DIYgod/RSSHub: 🍰 Everything is RSSible](https://github.com/DIYgod/RSSHub)


#### まず先にfetch

```bash
$ git remote add upstream ssh://git@github.com/DIYgod/RSSHub.git
$ git fetch upstream
```


#### 開発者向けのドキュメント

- [Join Us | RSSHub](https://docs.rsshub.app/en/joinus/)


#### 開発用のコマンド

使うのはこのへん

```bash
$ yarn dev
$ yarn docs:dev
```

```console
$ cat package.json | jq .scripts
{
  "start": "node lib/index.js",
  "dev": "cross-env NODE_ENV=dev nodemon --inspect lib/index.js",
  "docs:dev": "vuepress dev docs",
  "docs:build": "vuepress build docs",
  "format": "eslint \"**/*.js\" --fix && node docs/format.js && prettier \"**/*.{js,json,md}\" --write",
  "format:staged": "eslint \"**/*.js\" --fix && node docs/format.js && pretty-quick --staged --verbose --pattern \"**/*.{js,json,md}\"",
  "format:check": "eslint \"**/*.js\" && prettier-check \"**/*.{js,json,md}\"",
  "test": "npm run format:check && cross-env NODE_ENV=test jest --coverage --runInBand --forceExit",
  "jest": "cross-env NODE_ENV=test jest --runInBand --forceExit"
}
```


#### 過去のPR

- [feat: add router twitter/trends by sakamossan · Pull Request #4355 · DIYgod/RSSHub](https://github.com/DIYgod/RSSHub/pull/4355)
- [feat: add router yahoo-jp-tv by sakamossan · Pull Request #3928 · DIYgod/RSSHub](https://github.com/DIYgod/RSSHub/pull/3928)
