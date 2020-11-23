---
title: "cookiecutterでtypescript/jest/eslintのテンプレートを作った"
slug: cookiecutter-typescript-jest-eslint
date: 2020-09-06T14:00:34+09:00
draft: false
author: sakamossan
---

CRAだとnodejsのスクリプトを書くときとかは使えないのでcookiecutterにいいのがないか探してみたが、ちょっと古かったり(tslintを使っている)、不要な機能が色々入ってるのしかなかったので必要最小限のやつを自分で作った。

- [sakamossan/cookiecutter-node-typescript: Cookiecutter for Node.js with Typescript, Eslint, Jest, Prettier](https://github.com/sakamossan/cookiecutter-node-typescript)

cookiebutterの使い方はこんな感じ

```bash
$ cookiecutter git@github.com:sakamossan/cookiecutter-node-typescript.git
```

## 機能

`Jest` と `Eslint/Prettier` だけ入っている

```
$ tree -a
.
├── .eslintrc.js
├── .gitignore
├── .vscode
│   └── settings.json
├── README.md
├── jest.config.js
├── package.json
├── src
│   ├── __tests__
│   │   └── index.test.ts
│   └── index.ts
└── tsconfig.json
```

## 備考

- プロジェクトによって必要なものが色々違うはずなのでなるべく機能は少なめになっている
- テストとコードフォーマットはどうしたって使うはずなのでJestとEslint/Prettierは入っている
- eslint, prettier の設定はデフォルト(recommended)になっている

