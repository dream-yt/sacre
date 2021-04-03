---
title: "NestJSのDI/モジュール周りについてメモ"
slug: nestjs-module-injection-101
date: 2021-04-03T23:52:21+09:00
draft: false
author: sakamossan
---

nestjsの特徴と嬉しい点はDIの仕組みがしっかりしているところのようだ。
どのようにDIが機能しているかについて、ドキュメントとか記事をみてみたところをメモ。

## モジュール

- [Modules | NestJS - A progressive Node.js framework](https://docs.nestjs.com/modules)

`@Injectable` デコレータをサービスクラスにつけて定義すると、フレームワーク側の仕組みがよしなにコントローラにDIしてくれる。依存関係を宣言し、この仕組みを制御するために定義するのが `@Module` デコレータ。

### @Moduleの引数

`@Module` デコレータは以下の引数をとる

#### imports

> the list of imported modules that export the providers which are required in this module

モジュールが、どのモジュールに依存しているかを定義する


#### controllers

> the set of controllers defined in this module which have to be instantiated

nestjsでは最終的にコントローラがリクエストをハンドリングするので、エントリポイントはコントローラである。
定義した依存関係に沿ってコントローラにDIがされる。DIを受けるコントローラを定義している。


#### providers 

> the providers that will be instantiated by the Nest injector and that may be shared at least across this module

ここで定義したものは同じモジュール内で共用される。とくにサービスクラスがここに定義される。

なお、providers に定義するためにはクラスに `@Injectable` デコレータをつける必要がある。

#### exports

> the subset of providers that are provided by this module and should be available in other modules which import this module

providers の一種だが、他のモジュールでも使われるものはこちらに定義する。

### 例

```ts
@Module({
  imports: [],
  controllers: [AmodController],
  providers: [AmodService],
  exports: [AmodService],
})
```

```ts
@Module({
  imports: [AmodModule],
  controllers: [BmodController],
  providers: [BmodService],
})
export class BmodModule {}
```

- `BmodModule` が `AmodModule` に依存してることを定義している
- こう定義すると依存された側でexportsしているServiceを依存した側にDIされる
    - つまり `BmodController` が `AmodService` を呼び出せるようになる
    - `this.amodService` という按配

#### 参考

- [【NestJS】他のモジュールにあるサービスを使いたい（SharedModuleを作る） - Qiita](https://qiita.com/teracy55/items/0002033786db3543f4c2)


## コントローラ

最終的にコントローラがエントリポイントであり、作った実装を走らせるところなので、つまり注入した依存性はコントローラで使うために注入されているということになる。

コントローラのコンストラクタ引数の定義をフレームワーク側が参照して、初期化時にDIしてくれる仕組みがある。

> 特徴的なのはコンストラクタ。 NestJS では、フレームワークの機能により、コンストラクタにてクラスの型をもったインスタンスを引数に定義すると、自動的にそのインスタンスを this に格納してくれます。この場合、 this.appService に AppService が生えてきます。

- [触って覚える NestJS のアーキテクチャの基本 - Qiita](https://qiita.com/potato4d/items/aabb78fd201592352d64)

```ts
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }
}
```
