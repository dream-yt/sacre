---
title: "NestJS でハイフン混じりのリソースを定義するとき"
slug: nestjs-naming-convention-hyphen
date: 2021-04-04T00:00:38+09:00
draft: false
author: sakamossan
---

2単語にまたがるリソース名をつけようとするときどうするのが流儀に沿っているかわからなかったので調べたメモ。

結論としてはnestjsらしい名前をつけようとするとこんな感じということだ。

- クラス/モジュール名だとパスカルケース (例: `UserRole`)
- ファイル名だとハイフン区切り (例: `user-role` )

> I found out that NestJS library used hyphen-separated user-role.service.ts file naming as its convension.

- [node.js - File naming in Nest.js - Stack Overflow](https://stackoverflow.com/questions/61666498/file-naming-in-nest-js)

`nest generate` の引数に渡すときはハイフン区切りにすれば、そのクラス名はパスカルケースになってくれるのも確認した。

```bash
$ npx nest generate resource user-role --dry-run
? What transport layer do you use? REST API
? Would you like to generate CRUD entry points? Yes
CREATE src/user-role/user-role.controller.spec.ts (598 bytes)
CREATE src/user-role/user-role.controller.ts (971 bytes)
CREATE src/user-role/user-role.module.ts (270 bytes)
CREATE src/user-role/user-role.service.spec.ts (475 bytes)
CREATE src/user-role/user-role.service.ts (665 bytes)
CREATE src/user-role/dto/create-user-role.dto.ts (34 bytes)
CREATE src/user-role/dto/update-user-role.dto.ts (186 bytes)
CREATE src/user-role/entities/user-role.entity.ts (25 bytes)
UPDATE src/app.module.ts (421 bytes)
```
