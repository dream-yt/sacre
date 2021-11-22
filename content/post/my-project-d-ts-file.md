---
title: ".d.ts ファイルを自作してimportする"
slug: my-project-d-ts-file
date: 2021-08-01T10:05:04+09:00
draft: false
author: sakamossan
---

APIのTypeScriptの型定義ファイル(`foobar.d.ts`など)が提供されておらず、APIレスポンスをjson2tsなどにつっこんで型定義ファイルを得るということをよくやる

- [json2ts - generate TypeScript interfaces from json](http://json2ts.com/)

こんな型定義が得られる

```ts
declare module Kibela {
  export interface OutgoingWebhook {
    action: string;
    blog: Blog;
    resource_type: string;
  }

  export interface Blog {
    author: Author;
    boards: Board[];a
    content_html: string;
    content_md: string;
    id: string;
    title: string;
    url: string;
  }
}
```

これを `.ts`ではなく`.d.ts`で管理すると、型定義と実装が別ファイルで管理できて具合がいい

## .d.ts ファイルを作成

tscは `@types` という名前のディレクトリを見つけたらそれの中のものを型定義ファイルとして読み込んでくれる

> By default all visible “@types” packages are included in your compilation.

- [tsconfig.json · TypeScript](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html#types-typeroots-and-types)

`src/@types/foo.d.ts` といった場所にファイルを作成しておく

なお、`tsconfig.json#baseUrl` に指定がないと tsc が型定義ファイルを探せないので設定が必要。
`src/@types` 配下の定義を認識させるのなら以下のように設定する。

```diff
     "noUnusedLocals": false,
+    "baseUrl": "./src",
     "outDir": "lib",
```
## importする

こんな感じでimportすればnamespaceが使える

```ts
import './@types/foo';
```


## 参考

- [typeRootsの誤解 -- TypeScriptで、npmからインストールしたパッケージに型定義ファイル (*.d.ts) が存在しない場合の正しい対処方法 - Qiita](https://qiita.com/tetradice/items/b89a5dd41fcebf96379e)
