---
title: "ts-migrateをつかった"
slug: ts-migrate-101
date: 2020-08-26T14:08:12+09:00
draft: false
---

ちょうど ts に移行する雰囲気があったので使ってみた

- [airbnb/ts-migrate: A tool to help migrate JavaScript code quickly and conveniently to TypeScript](https://github.com/airbnb/ts-migrate)

## ts-migrate がやってくれること

主な機能は以下の2つ

- `$ ts-migrate rename`
  - js => ts のリネーム
- `$ ts-migrate migrate`
  - コンパイルエラーが出る箇所を `any`, `@ts-expect-error` で抑制
  - もちろん機械的な変換なのでロジックは変更されない

ts-migrateを使うと `allowJs` をつけてjsとtsを共存させながら徐々に移行するというのをしないで済む。jsファイルを型定義/チェックもなにもないめちゃユルいtsファイルに一括変換できてしまうのがこのツールの便利なところ


## コマンド

最低限で使うのならこんなコマンドから機械的に{js=>ts}に変換できてしまう

```bash
# jsファイルからtsファイルにrename
$ npx ts-migrate rename .
# コンパイルエラーを抑制
$ npx ts-migrate migrate .
```

webpackとかjestの設定を直すだけで移行が済んでしまう


## tsconfig#{include/exclude}

特定のディレクトリを移行対象から外したい/含めたいというコントロールは `tsconfig.json` の include, exclude の項目を ts-migrate が参照してくれるのでそれを使う。 `build` とかのディレクトリは exclude しておく。


## 参考

- [ts-migrate: A Tool for Migrating to TypeScript at Scale | by Sergii Rudenko | Airbnb Engineering & Data Science | Aug, 2020 | Medium](https://medium.com/airbnb-engineering/ts-migrate-a-tool-for-migrating-to-typescript-at-scale-cd23bfeb5cc)