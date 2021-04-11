---
title: "Nest can't resolve dependencies of the FooService"
slug: nestjs-prisma-error-to-resolve-deps
date: 2021-04-04T13:12:31+09:00
draft: false
author: sakamossan
---

NestJS のテストで以下のエラーになった。
これは新しい依存(Prisma)を Denylist モジュールに追加したときに発生した。

```
    Nest can't resolve dependencies of the DenylistService (?). Please make sure that the argument PrismaService at index [0] is available in the RootTestModule context.

    Potential solutions:
    - If PrismaService is a provider, is it part of the current RootTestModule?
    - If PrismaService is exported from a separate @Module, is that module imported within RootTestModule?
      @Module({
        imports: [ /* the Module containing PrismaService */ ]
      })
```

エラーの原因はテストでの providers に追加し忘れ。エラーメッセージの指示通り、サービスが依存するようになったクラスをテストのprovidersにも追加しないといけない。

 ```diff
   beforeEach(async () => {
     const module: TestingModule = await Test.createTestingModule({
-      providers: [DenylistService],
+      providers: [DenylistService, PrismaService],
     }).compile();
```
