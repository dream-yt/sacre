---
title: "Prisma でスキーマ変更を本番に反映する"
slug: prisma-apply-migration
date: 2021-04-18T22:10:01+09:00
draft: false
author: sakamossan
---

`.env.migrate` というファイルに本番DBにDDLを流せる接続情報が記述されているとして。

### 確認

どこまでマイグレーションファイルが適用されているかを確認。

```bash
npx dotenv -e .env.migrate -- npx prisma migrate status
```

### 適用

確認した内容が問題なければ適用。

```bash
npx dotenv -e .env.migrate -- npx prisma migrate deploy
```

## 参考

- [Prisma schema (Reference) | Prisma Docs](https://www.prisma.io/docs/concepts/components/prisma-schema#manage-env-files-manually)


