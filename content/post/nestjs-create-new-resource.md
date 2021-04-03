---
title: "NestJS でエンドポイント(リソース)を追加する"
slug: nestjs-create-new-resource
date: 2021-04-03T23:56:26+09:00
draft: false
author: sakamossan
---

エンドポイント新規に追加するときは generate コマンドを使う。
`generate resource` とすると、ひとそろい作ってくれる。

> nest generate resource [resource-name]

たとえば、`denylist` というリソースのためのRESTAPIを作りたいときはこのようになる。

```bash
$ npx nest generate resource denylist --dry-run
? What transport layer do you use? REST API
? Would you like to generate CRUD entry points? Yes
CREATE src/denylist/denylist.controller.spec.ts (638 bytes)
CREATE src/denylist/denylist.controller.ts (1055 bytes)
CREATE src/denylist/denylist.module.ts (298 bytes)
CREATE src/denylist/denylist.service.spec.ts (503 bytes)
CREATE src/denylist/denylist.service.ts (721 bytes)
CREATE src/denylist/dto/create-denylist.dto.ts (38 bytes)
CREATE src/denylist/dto/update-denylist.dto.ts (202 bytes)
CREATE src/denylist/entities/denylist.entity.ts (29 bytes)
UPDATE package.json (2001 bytes)
UPDATE src/app.module.ts (342 bytes)
```

- [Usage - CLI | NestJS - A progressive Node.js framework](https://docs.nestjs.com/cli/usages#nest-generate)
