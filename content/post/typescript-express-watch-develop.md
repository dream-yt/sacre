---
title: "typescript で express を watch しながら開発する"
date: 2020-05-06T21:41:26+09:00
draft: false
author: sakamossan
---

nodemon と ts-node を使えばできる

たとえば `src/index.tsx` が express アプリなら以下のコマンドになる

```bash
nodemon -r ts-node/register ./src/index.tsx
```

- `nodemon`
  - 配下のファイルが変更されたらサーバをリロードしてくれる
- `-r ts-node/register ./src/index.tsx`
  - index.tsx を tsconfig.json の定義にしたがってビルドしてくれる

なお、  nodemon.json を置いておくと設定ができる

```json
{
  "ignore": [
    ".git",
    "node_modules",
    "dist"
  ],
  "watch": [
    "src"
  ]
}
```


## 参考

- [Create a server with Nodemon + Express + Typescript](https://medium.com/create-a-server-with-nodemon-express-typescript/create-a-server-with-nodemon-express-typescript-f7c88fb5ee71)
