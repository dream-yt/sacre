---
title: "Prisma の NestJS へのつなぎ込み"
slug: nestjs-prisma-integlation
date: 2021-04-04T11:51:56+09:00
draft: false
author: sakamossan
---

```bash
$ yarn add prisma @prisma/client
$ npx prisma init # TODO CI/本番など実行環境ごとに .env を切り替える方法が欲しい
```

## スキーマの編集

```
$ code prisma/schema.prisma
```

まずは sqlite で動作させる。

```js
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "sqlite"
  url      = "file:./admin.db"
}

model Denylist {
  id String @id
  expireAt DateTime?
  createdAt DateTime @default(now())
}
```

- [Prisma schema API (Reference) | Prisma Docs](https://www.prisma.io/docs/reference/api-reference/prisma-schema-reference#model-fields)

prisma 内での model の名前の規約はこのようになっている

> Must start with a letter

> Typically spelled in camelCase

> Must adhere to the following regular expression: [A-Za-z][A-Za-z0-9_]*


## migrate & generate

モデルを定義したらmigrate。ここでsqliteファイルにテーブルが生成される。

```bash 
$ npx prisma migrate dev --name create-table-denylist
```

generate すると scheme の定義内容をもとにjsランタイムのソースコードが node_modules 配下に生成される (ちゃんと型付で import できるようになる)

```bash
$ npx prisma generate
```

## .gitignore

sqlite なのでデータベースファイルをignoreする

```
# prisma
prisma/*.db
prisma/*.db-journal
```

## NestJSのサービスにする

公式のとおりにサービス化すればコントローラ/他サービスでも使えるようになる。

- [Prisma | NestJS - A progressive Node.js framework](https://docs.nestjs.com/recipes/prisma)

```bash
$ npx nest generate service prisma
$ code src/prisma/prisma.service.ts
```

### prisma.service.ts

```ts
import { Injectable, OnModuleInit, OnModuleDestroy } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService
  extends PrismaClient
  implements OnModuleInit, OnModuleDestroy {
  async onModuleInit() {
    await this.$connect();
  }

  async onModuleDestroy() {
    await this.$disconnect();
  }
}
```

module.ts の定義。

```diff
 @Module({
+  imports: [PrismaService],
   controllers: [DenylistController],
   providers: [DenylistService],
 })
```

service.ts では constructor に定義すれば this から使える。

```diff
-  create(createDenylistDto: CreateDenylistDto) {
-    return 'This action adds a new Denylist';
+  constructor(private prisma: PrismaService) {}
+
+  create(data: CreateDenylistDto) {
+    return this.prisma.Denylist.create({data});
   }
```

### テストが落ちる

テストで依存性が解決できないというエラーになるのでそちらも直す。


- ["make sure that the argument HttpService at index [0] is available" NestJS error - My Day To-Do](https://mydaytodo.com/make-sure-that-the-argument-httpservice-at-index-0-nestjs/)
