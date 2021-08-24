---
title: "ts-node で型定義にパスが通らないときに力ずくで通す方法ともう少しマシな方法"
slug: ts-node-baseUrl-issue-nobrain
date: 2021-08-24T15:04:10+09:00
draft: false
author: sakamossan
---

tsconfig.json で baseUrl を指定しているときに ts-node はそれを解決してくれない。

- [tsconfig.json/paths not working with ts-node · Issue #138 · TypeStrong/ts-node](https://github.com/TypeStrong/ts-node/issues/138)

型定義がないパッケージを使っていて index.d.ts などにせこせこ型定義をしていると ts-node がそれを見てくれないので実行できない。

これは issue になっているが、ts-node 単体ではまだ修正されていない。

- [tsconfig.json/paths not working with ts-node · Issue #138 · TypeStrong/ts-node](https://github.com/TypeStrong/ts-node/issues/138)

これは mackerel パッケージの型定義がないので実行に失敗したときのログ。 `tsconfig.json#baseUrl:"src"` として `./src/@types/index.d.ts` に型定義を置いているので tsc だとコンパイルは通るが ts-node だと通らない。

```
$ npx ts-node index.ts

/Users/myuser/.ghq/github.com/myuser/app/node_modules/ts-node/src/index.ts:434
    return new TSError(diagnosticText, diagnosticCodes)
           ^
TSError: ⨯ Unable to compile TypeScript:
job/scrape-work-status/manager.ts(2,42): error TS7016: Could not find a declaration file for module 'mackerel'. '/Users/myuser/.ghq/github.com/myuser/app/node_modules/mackerel/lib/mackerel.js' implicitly has an 'any' type.
  Try `npm i --save-dev @types/mackerel` if it exists or add a new declaration (.d.ts) file containing `declare module 'mackerel';`

    at createTSError (/Users/myuser/.ghq/github.com/myuser/app/node_modules/ts-node/src/index.ts:434:12)
```


## 力ずくで通す

とりあえず実行したかったので index.d.ts を node_modules 配下に撒いて動くようにした。

```bash
$ cp ./src/@types/index.d.ts ./node_modules/mackerel/
```


## もうすこしマシな方法

`tsconfig-paths` というパッケージがあり、これは `tsconfig.json#path` に指定したものはなんとかしてくれるので、これを使っている人もいるようだった。こっちだと node_modules に妙なことをする必要はない。

- [tsconfig.json/paths not working with ts-node · Issue #138 · TypeStrong/ts-node](https://github.com/TypeStrong/ts-node/issues/138#issuecomment-296765802)
- [tsconfig-paths - npm](https://www.npmjs.com/package/tsconfig-paths)

ただし、path の書き換えはようやらないので個人的には使いたくない感じがある。ためしに実行したかっただけなので力ずくでなんとかしてしまった。
