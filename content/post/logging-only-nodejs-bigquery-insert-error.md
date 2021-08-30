---
title: "nodejsのBigQuery#insertに失敗したときに原因の行だけログに出す"
slug: logging-only-nodejs-bigquery-insert-error
date: 2021-08-30T15:10:56+09:00
draft: false
author: sakamossan
---

nodejs で BigQuery に insert するとき、1行でも不正な行があると全体が失敗する。そしてどの行がなぜ失敗したのかを確認するのにはちょっと工夫が必要である。

まず、不正な行があると `PartialFailureError` という例外が投げられて、これに不正な行がどれでそれがどういうふうにダメだったのかが入っている。

ドキュメントによるとデータ構造はこうなっている。

```ts
e.errors (object[]):
e.errors[].row (original row object passed to `insert`)
e.errors[].errors[].reason
e.errors[].errors[].message
```

- [Table - Documentation](https://googleapis.dev/nodejs/bigquery/latest/Table.html#insert-examples)


## 実装

`PartialFailureError` にはすべての行の情報が入ってしまっているので、大量のレコードを insert しようとしているときにそれをそのままログにだすと、ログも大量になってしまう。

必要なものに絞るためこんな実装で期待通りのログを出すことができた。

```ts
try {
  await bq.dataset("ds").table("tbl").insert(data);
} catch (error) {
  if (error.name == 'PartialFailureError') {
    const invalidRowErrors = error.errors!
      .flatMap((err: any) => {
        if (!err.errors) {
          return [];
        } else {
          return err.errors.flatMap(({ reason, message }: any) =>
            reason == 'stopped' && message == "" 
              ? [] 
              : { row: err.row, reason, message }
          )
        }
      })
    console.error(invalidRowErrors)
    console.error(error.stack || error.message);
  }
}
