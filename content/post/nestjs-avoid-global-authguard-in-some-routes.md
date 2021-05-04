---
title: "NestJS の認証で、一部のルートだけ認証不要でアクセスさせたい"
slug: nestjs-avoid-global-authguard-in-some-routes
date: 2021-05-04T22:06:35+09:00
draft: false
author: sakamossan
---

こちらの続編。

- [passport 入門と NestJS で使う場合のメモ](https://blog.n-t.jp/tech/nestjs-passport-101/)

NestJS の `App#useGlobalGuards` を使うと、すべてのルート(エンドポイント)に対して認証をかけることができる。ルートを実装するごとにいちいち依存を定義してデコレータでGuardをつけるのは面倒なのでこの機能はとても便利である。
しかし、一部のルートだけ認証せずにアクセスさせたい場合がある。たとえば、Prometheus からアクセスされるスコアボードなどは認証をかけたくない。

そういうときに一部のルートだけ明示的にPublicにするための方法が GitHub issue で案内されていた。

- [Add exclude feature for useGlobalGuards · Issue #964 · nestjs/nest](https://github.com/nestjs/nest/issues/964)

## 方法

- `@nestjs/common` の `SetMetadata` を使い、ルートがパブリックであることを明示できるデコレータを実装する
- 認証を行うGuardの中でルートのコンテキストを参照し、もしルートがパブリックなら認証処理をせずにコントローラに処理を受け渡す実装をする
- 認証を不要にしたいルートに件のデコレータを設定する


### 認証をしないためのデコレータ

`SetMetadata` はルートにかけるデコレータをつくるためのヘルパーである。ここで設定されたメタデータは して、Reflector 

```ts
import { SetMetadata } from '@nestjs/common';

export const IS_PUBLIC_KEY = 'isPublic';
export const Public = () => SetMetadata(IS_PUBLIC_KEY, true);
```

- [Execution context | NestJS - A progressive Node.js framework](https://docs.nestjs.com/fundamentals/execution-context#reflection-and-metadata)


### 認証処理でルートのメタデータを参照する

Guard の canActivate を override して、Reflector からルートに設定されたコンテキストを参照する。

```ts
@Injectable()
export class JwtAuthGuard extends AuthGuard('jwt') {
  constructor(private reflector: Reflector) {
    super();
  }

  // override
  canActivate(context: ExecutionContext) {
    const isPublic = this.reflector.getAllAndOverride<boolean>(IS_PUBLIC_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);
    // ルートの `IS_PUBLIC_KEY` フラグがたっていたらtrueを返してしまう
    if (isPublic) {
      return true;
    }
    return super.canActivate(context);
  }
}
```

#### Reflector を Guard に渡す

`JwtAuthGuard` のコンストラクタで `Reflector` が必要になったので引数で渡すようにする。

```ts
  const reflector = app.get(Reflector);
  app.useGlobalGuards(new JwtAuthGuard(reflector));
```


### パブリックにしたいルートにデコレータを設定する


```ts
import { Public } from './auth/public';

...

  @Public()
  @Get()
  getHello(): string {
    return this.appService.getHello();
  }
```


## 参考

- [Authentication | NestJS - A progressive Node.js framework](https://docs.nestjs.com/security/authentication)
