---
title: "NestJSでPOSTパラメータをクラスのインスタンスに変換して受け取る"
slug: nestjs-class-transformer-pipe
date: 2021-04-29T16:23:16+09:00
draft: false
author: sakamossan
---

NestJS では `class-transformer` を使って、クライアントから渡されたデータを、jsのクラスのインスタンスにした状態で受け取ることができる。たとえば、日時のデータを文字列からDate型にしてくれるのは便利なのだが、これがびっくりするほど簡単に実現できる。

### 必要な作業

- 依存パッケージのインストール
- DTOクラスにデコレーターで定義を行う
- `ValidationPipe` を `useGlobalPipes` に登録する

## 依存パッケージのインストール

```bash
$ yarn add class-validator class-transformer
```

ついでで `class-validator` でのバリデーションも有効にできるので、ついでで入れる。


## DTOクラスにデコレーターで定義を行う

この例はコントローラの更新処理の定義。

```ts
  @Put(':id')
  update(
    @Param('id') id: string,
    @Body() updateUserDto: UpdateUserDto,
  ) {
    return this.service.update(+id, updateUserDto);
  }
```

`UpdateUserDto` を以下のように定義する。

`expireAt` は日時を表すデータだが、POSTされた文字列をDateにしてくれるよう `class-transformer#Type` に指定する。

```ts
import { IsDate, IsString, IsNotEmpty } from 'class-validator';
import { Type } from 'class-transformer';

export class CreateUserDto {
  @IsString()
  @IsNotEmpty()
  readonly name: string;

  @IsDate()
  @Type(() => Date)
  readonly expireAt: Date;
}

export class UpdateUserDto extends PartialType(CreateUserDto) {}
```

## `ValidationPipe` を `useGlobalPipes` に登録する

`main.ts` で処理を挟み込む。`{transform: true}` のオプションを渡す。

```ts
import { ValidationPipe } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(new ValidationPipe({ transform: true }));
```

## 参考

- [Pipes | NestJS - A progressive Node.js framework](https://docs.nestjs.com/pipes)
- [typestack/class-transformer: Decorator-based transformation, serialization, and deserialization between objects and classes.](https://github.com/typestack/class-transformer)


## 所感

いままでデコレータって仕様も決まってないし使わない方がいいんじゃないかなと思っていたが、こんなことができるなら仕様変更で多少面倒な思いをしてでも使った方がいいなってなった。
