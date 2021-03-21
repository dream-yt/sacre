---
title: "prisma でアプリが使うClientのコードを生成する"
slug: prisma-101-generate-client
date: 2021-03-21T23:48:14+09:00
draft: false
author: sakamossan
---

もともとテーブル定義があって、そこからORMのコードを生成するまでのメモ。
手順はドキュメントの通り。

- [Add to existing project (TypeScript & PostgreSQL) | Prisma Docs](https://www.prisma.io/docs/getting-started/setup-prisma/add-to-existing-project-typescript-postgres)

### インストール

```
npm install prisma --save-dev
```


### init

```
npx prisma init
```

- prismaディレクトリが生成される
- `.env` ファイルと `schema.prisma` ファイルの雛形が生成される
- `schema.prisma` ファイルとはスキーマ定義からTypeScriptのコードを生成するための中間表現のようなファイルで、自動的に生成されるが人間も読み書きする。


### introspect

`schema.prisma` ファイルのDBとのコネクション情報を管理する `datasource` の設定を埋めたら、`prisma introspect` を叩く。

```
npx prisma introspect
```

prismaがDBに接続して、テーブル定義を読んで `schema.prisma` ファイルを更新してくれる。


### schema.prisma の修正

自動生成された内容を人間がコードを書きやすいように修正する。たとえばカラム名を直したり、relation定義を明確にしたりといった作業。

もしカラム名がスネークケースだったりするなら修正するのはこのタイミング。

- [#introspect-your-database-with-prisma](https://www.prisma.io/docs/getting-started/setup-prisma/add-to-existing-project-typescript-postgres#introspect-your-database-with-prisma)


### generate

`schema.prisma` が修正できたら、それをもとにTypeScriptのコードを生成する。

```
npm install @prisma/client
npx prisma generate
```

コードは `node_modules/.prisma/client` に生成される。

![prisma-client-node-module](https://www.prisma.io/docs/static/23697e3841e07a262f2e2eae70d11b19/a6d36/prisma-client-node-module.png)

↑の図がわかりやすいが、ここに吐き出されたコードを `@prisma/client` モジュールが参照する形になっている。


### update

スキーマ定義が変更されたら、 `introspect` と `generate` をその度に叩いてアプリが参照するORMのコードを更新しながら使う。

![update](https://imgur.com/ToNkpb2.png)

デプロイとスキーマ定義変更のミスマッチ期間についてはこちらに記載されていた(試していない)

- [Deploying projects using Prisma to the cloud | Prisma Docs](https://www.prisma.io/docs/guides/deployment/deployment#deploying-database-changes-with-prisma-migrate)


### その他

`studio` コマンドで管理画面みたいなものが立ち上がって、簡単なデータ操作ができる。

```
npx prisma studio
```

