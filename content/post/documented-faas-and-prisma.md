---
title: "FaaSでPrisma(DBMS)を使う際のドキュメント"
slug: documented-faas-and-prisma
date: 2021-03-29T15:34:29+09:00
draft: false
author: sakamossan
---

- [Deploying projects using Prisma to the cloud | Prisma Docs](https://www.prisma.io/docs/guides/deployment/deployment#serverless-faas)

PrismaのドキュメントにはFaaSで使う場合のアドバイスがいろいろ書いてあった。
あるあるな困りごとについてよくまとまっているのでメモ。

たとえば 「FaaSのプロセスがいくつもコネクションを張る必要はなく、またそれをするとスパイク時にDBMS側のリソースが枯渇するのでやめましょうね」というようなことが色々と書いてあった。

> Serverless (FaaS): It's recommended to set the connection limit to 1 if you're not using an external connection pooler because each incoming request starts a short-lived Node.js process. This can cause the database connection pool to be quickly exhausted from a short spike in user traffic.



## Container reuse

FaaSが呼ばれる時に、毎度コンテナが立ち上がるか再利用されるかを制御することができないという話。

#### Description

> It is not guaranteed that subsequent nearby invocations of a function will hit the same container. AWS can choose to create a new container at any time.

#### Potential Solution

> Code should assume the container to be stateless and create a connection only if it does not exist. Prisma Client JS already implements that logic.

## Zombie connections

FaaSの処理が終了しても、コンテナ内でプロセスとコネクションが残ってしまってDBMSのリソースを消耗させてしまうという話。

#### Description

> The containers that are marked to be removed and are not being reused still keep a connection open and can stay in that state for some time (unknown and not documented from AWS), this can lead to sub-optimal utilization of the DB connections

#### Potential Solution

> One potential solution is to use a lower idle connection timeout. Another solution can be to clean up the idle connections in a separate service

タイムアウトの数値を少なくするという方法がある。


## Database connection pool exhaustion

リクエストがスパイクして、FaaSのプロセスが多数同時に立ち上がるとDBMS側のリソースが枯渇するという話。

#### Description

> Concurrent requests create multiple new connections to the database thereby exhausting the database's connection limit.

#### Potential Solution

> Add a connection pooler, e.g. PgBouncer or limiting the serverless function concurrency to a number lower than the database's connection limit.



# その他

GCP の Cloud Function で Prisma を動かすサンプルが公開されていた。

- [e2e-tests/platforms/gcp-functions at dev · prisma/e2e-tests](https://github.com/prisma/e2e-tests/tree/dev/platforms/gcp-functions)

> GCP allows deploying just the project and fetches the modules for the user. To generate the Prisma client, we use the npm postinstall hook. Using the gcp-build hook does not work, since Google regenerates node_modules after that hook is executed.

```json
  "scripts": {
    "postinstall": "CI=1 && PRISMA_TELEMETRY_INFORMATION='e2e-tests platforms/gcp-functions postinstall' && yarn prisma generate"
  },
```

