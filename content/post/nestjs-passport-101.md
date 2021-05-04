---
title: "passport 入門と NestJS で使う場合のメモ"
slug: nestjs-passport-101
date: 2021-05-04T16:45:54+09:00
draft: false
author: sakamossan
---

passport とは express 上で使う認証フレームワーク。NestJS は express 上に構築されているので NestJS でも passport と周辺のライブラリを利用することができる。

こちらを読んでメモ

- [Authentication | NestJS - A progressive Node.js framework](https://docs.nestjs.com/security/authentication)

## Strategy

- passport というフレームワークでは Strategy ごとそれぞれ `validate()` メソッドを実装する必要がある
    - Strategy ごとにメソッドのシグネチャは異なる
- passport フレームワーク が実装されたメソッドを適宜呼び出して認証を行う

> We've also implemented the validate() method. For each strategy, Passport will call the verify function (implemented with the validate() method in @nestjs/passport) using an appropriate strategy-specific set of parameters. For the local-strategy, Passport expects a validate() method with the following signature: validate(username: string, password:string): any.

### いろいろな Strategy

- passport-local
    - POSTパラメータとしてリクエストされた username, password の2つの認証情報を検証する Strategy
- passport-jwt
    - リクエストヘッダに載った JSON Web Token を認証情報として検証する Strategy
    - [【JWT】 入門 - Qiita](https://qiita.com/Naoto9282/items/8427918564400968bd2b)


## Strategy#validate() 

- `validate()` メソッドが期待通りに実装されていれば passport はフレームワークとしてその他の処理を裏側で行ってくれる
- `validate()` メソッドで定義する必要があるのは「要求されたユーザの情報を返却すること」のみ
    - passport はここで返却されたユーザデータを `req.user` として生やしてくれる機能もうけもっている
- もちろん認証エラーとなった場合は401を返す

>  If a user is found and the credentials are valid, the user is returned so Passport can complete its tasks (e.g., creating the user property on the Request object)

> Typically, the only significant difference in the validate() method for each strategy is how you determine if a user exists and is valid.


## NestJS から使うとき

NestJS から使う時は、たとえば以下のような Strategy クラスを Injectable として実装して

#### auth/local.strategy.ts

```tsx
@Injectable()
export class LocalStrategy extends PassportStrategy(Strategy) {
  constructor(private authService: AuthService) {
    super();
  }

async validate(username: string, password: string): Promise<any> {
    const user = await this.authService.validateUser(username, password);
    if (!user) {
      throw new UnauthorizedException();
    }
    return user;
  }
}
```

それを Guard クラスとしてラップし

#### auth/local-auth.guard.ts

```ts
@Injectable()
export class LocalAuthGuard extends AuthGuard('local') {}
```

#### app.controller.ts

コントローラ側で `@UseGuards` して使うことになる

```ts
@Controller()
export class AppController {
  constructor(
    private readonly appService: AppService,
    private authService: AuthService,
  ) {}

  // username/password が検証できないと401を返す
  @UseGuards(LocalAuthGuard)
  @Post('auth/login')
  async login(@Request() req) {
    // username/password が検証できたらトークンを返すエンドポイント
    return this.authService.login(req.user);
  }
}
```
