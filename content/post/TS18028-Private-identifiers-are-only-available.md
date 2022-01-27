---
title: "TypeScript で error TS18028: Private identifiers are only available when targeting ECMAScript 2015 and higher"
slug: TS18028-Private-identifiers-are-only-available
date: 2022-01-27T17:27:42+09:00
draft: false
author: sakamossan
---

TypeScriptのビルド時に以下のようなエラーに遭遇した。

> error TS18028: Private identifiers are only available when targeting ECMAScript 2015 and higher

```console
$ ./scripts/deploy.sh --function myfunc
node_modules/cloudevents/dist/event/cloudevent.d.ts:15:5 - error TS18028: Private identifiers are only available when targeting ECMAScript 2015 and higher.

15     #private;
       ~~~~~~~~


Found 1 error.
```

これは `tsconfig.json` の `target` の設定に起因している。`target` は「どのversionのJavaScriptソースコードを出力するか」という設定である。

- `target` が `ES3` など古い仕様をしているときに
- TypeScript(もしくは型定義)のコードで `#private` など新しい記法を使っている

というときのエラーとなる。自分が書いていなくても使っているライブラリがそういった記法を使っていればビルドができない。


## 解決

`ES2015` 以上のモダンな仕様を指定するようにすればよい。

```json
  "target": "ES2015",
```

おそらく大体の場合はES2017とか、もう少し新しい仕様を指定しても大丈夫になっているはずである。
