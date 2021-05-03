---
title: "NestJS/class-transformer でPOSTされなかったパラメータにデフォルトを設定する"
slug: nestjs-default-value-on-post-params
date: 2021-05-02T13:11:30+09:00
draft: false
author: sakamossan
---

前回までのあらすじ

- [NestJSでPOSTパラメータをクラスのインスタンスに変換して受け取る](https://blog.n-t.jp/tech/nestjs-class-transformer-pipe/)

文字列で渡ってきた `"2011-01-01 12:34:56"` という文字列を `new Date("2011-01-01 12:34:56")` された状態で扱うことはできるようになったが、今度はこれにデフォルト値を入れた状態でコントローラが受け取るための方法。

たとえば、`expireAt` というフィールドがあって、これが `null` でPOSTされてきたときに二ヶ月後のDateが入った状態で処理を開始したい場合はこんなコードを書けばよい。

```tsx
import { addMonths } from 'date-fns';
import { Type, Transform } from 'class-transformer';
export class CreateSampleDto {
  @IsDate()
  @IsNotEmpty()
  @Type(() => Date)
  @Transform(({ value }) => value || addMonths(new Date(), 1), {
    toClassOnly: true,
  })
  expireAt: Date;
}
```

- [feat: use default value for property when doing plainToClass · Issue #129 · typestack/class-transformer](https://github.com/typestack/class-transformer/issues/129)


## Caveat

NestJS の `ValidationPipe` が `undefined` だったフィールドは処理してくれないので、falsyな値をつけてPOSTしないと期待通りに動作しない。

つまり、この値をPOSTした場合は期待通り二ヶ月後の日付が入るが

```json
{"id": 1, "expireAt": null}
{"id": 1, "expireAt": "0"}
```

こんな値をPOSTした場合は、そもそもデフォルト値を入れるための処理が呼ばれない。

```json
{"id": 1}
{"id": 1, "expireAt": undefined}
```

意図せぬ値がDBに入らないように `class-validator` の `IsNotEmpty` を使うと、`undefined` をPOSTした場合は弾いて、`null` をPOSTした場合は期待通りに動作するようになる。`IsNotEmpty` は `Transform` よりも後に呼ばれるようだ。

苦しい感じでなんとかしているが、クライアント側からするとよくわからない仕様なので本当は `undefined` を投げられた場合もなんとかしたい。
