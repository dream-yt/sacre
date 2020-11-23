---
title: "aws-cdkを使い始めるまでメモ"
slug: aws-cdk-101
date: 2018-11-17T22:30:32+09:00
draft: false
author: sakamossan
---

プロジェクトを作成する

`app` ってのはサブコマンドで、「アプリ開発者として使う」という意味
(`lib`ってのがあって、それはcdkのライブラリ作者が使うらしい)

```bash
$ cdk init app --language typescript
```

補完を効かせながら開発したいので追加

```bash
$ yarn add --dev \
    tslint prettier \
    tslint-config-prettier tslint-config-standard tslint-plugin-prettier 
$ code ./tslint.json
```

使いたいAWSサービスの定義を加えて開発

```bash
$ yarn add @aws-cdk/aws-cognito
$ code ./bin/infra.ts
```

cloudformationの形式のファイルを出力

```bash
# cdk.jsonで定義された位置にjsファイルを生成
$ yarn run build
# そのjsを読んでcloudformationの形式を出力
$ cdk synth > ./cf.yaml
```

### 参考

- [examples/cdk-examples-typescript · awslabs/aws-cdk](https://github.com/awslabs/aws-cdk/tree/6495e3ccd335ce9cb4438cfc285ca2bdb921f52a/examples/cdk-examples-typescript)
