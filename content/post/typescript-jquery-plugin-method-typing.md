---
title: "TypeScriptでjQueryプラグインにて追加した関数の型定義"
slug: typescript-jquery-plugin-method-typing
date: 2020-08-17T18:22:13+09:00
draft: false
author: sakamossan
---

index.d.ts ファイルを用意して以下のようにメソッドを追加すればよい

```ts
interface JQuery {
  foo(arg: string): jQuery;
}
```

jQueryはネームスペースを切らずに型を定義しているので、グローバル空間にてinterface宣言からメソッドを記述してやると、既存のJQueryにメソッドが追加された状態になってくれる

- [DefinitelyTyped/JQuery.d.ts at master · DefinitelyTyped/DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped/blob/master/types/jquery/JQuery.d.ts#L5)

## 参考

- [インターフェース - TypeScript Deep Dive 日本語版](https://typescript-jp.gitbook.io/deep-dive/type-system/interfaces)
