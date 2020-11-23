---
title: "雑create-react-app のデプロイについて"
slug: create-react-app-rough-deploy
date: 2020-06-18T10:38:39+09:00
draft: false
author: sakamossan
---

### init

こんな感じで開発を始める

```bash
npm install -g create-react-app
npx create-react-app {{ アプリ名 }} --typescript
yarn start
```


### build

ビルドコマンドはデフォルトで用意されている

```bash
yarn build
```

これを実行すると `./build` 配下にhtmlなどビルド結果が生成される


### deploy

AWSを使ってるとしてs3にあげる例だとこんな感じ

```bash
aws s3 sync --delete ./build s3://static-bucket-name/thirdapp
```


## パスの調整

create-react-app の yarn build はデフォルトだとパスをルート `/` からの絶対パスで生成する

```html
<link rel="apple-touch-icon" href="/logo192.png"/>
``` 

`s3://static-bucket-name/thirdapp/` にアプリを置きたい場合はこれを `/thirdapp/` 配下にする必要があるが、そのパスの変更は `package.json#homepage` で設定できる

こんな感じ

```json
$ cat package.json
{
  "name": "thirdapp",
  "version": "0.1.0",
  "private": true,
  "homepage": "/thirdapp/",
  "dependencies": {
  ...
```
