---
title: "typescriptで特定ファイルのコンパイルエラーだけdisableする"
slug: typescript-ts-ignore
date: 2019-02-23T19:57:57+09:00
draft: false
author: sakamossan
---

typescriptのコンパイラオプションは一般的にはtsconfig.jsonでプロジェクト全体のコンパイルの設定を定義することになる。たとえば `strictNullChecks` とか `noUnusedLocals` といった項目を設定する。

```json
    "esModuleInterop": true,
    "noUnusedLocals": true,
    "strictNullChecks": true,
```

フレームワークや動作環境によってこれらの制約を守れない。という場合に特定ファイルだけコンパイルチェックをskipする設定がある

## たとえば

たとえばexpressのルーティングをするときに、引数に渡す関数のシグネチャは決まっている

```ts
interface RequestHandler {
    (req: Request, res: Response, next: NextFunction): any;
}
```

実際に使われるところはこんな感じ

```ts
app.get('/*', (req: Express.Request, res: Express.Response) => {
  return res.send("hello");
});
```

だが、上記のようなコードだとreq変数にアプローチしない場合はエラーになってしまう

> 'req' is declared but its value is never read.

しかしフレームワーク（express）を使っている以上はフレームワークに従わないといけないので困ってしまう


## @ts-ignore

こういった場合は `// @ts-ignore` というコメントを入れると、その部分だけのコンパイルチェックを多めに見ることができる

こんな感じ

```ts
// @ts-ignore TS6133: 'req' is declared but its value is never read.
app.get('/*', (req: Express.Request, res: Express.Response) => {
  return res.send("hello");
});
```


## 参考

- [TypeScript 2.6 · TypeScript](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-2-6.html#suppress-errors-in-ts-files-using--ts-ignore-comments)
