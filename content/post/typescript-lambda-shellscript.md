---
title: "TypescriptでLambdaのハンドラーを書いてbashでアップロードする"
date: 2019-08-04T13:16:56+09:00
draft: false
---

普通だとlambdaのアップロードはserverlessなどフレームワークを使うが、package.jsonを別に作りたくない場合があり、デプロイをシェルスクリプトでやったのでメモ

```bash
#!/bin/bash
set -eu
cd $(dirname $0)

$(npm bin)/tsc --build --clean && $(npm bin)/tsc --build

zip -qr ~/Desktop/lambda.zip \
  ./index.js \
  $(find ./src -name '*.js' -o -name '*.js.map' -type f) \
  ./node_modules

aws lambda update-function-code \
  --function-name MyLambda \
  --zip-file fileb://~/Desktop/lambda.zip
```

- `./node_modules` 配下のdevDepsがzipに入り込んでしまうのが微妙
- zipファイルが10MB以上の場合はs3デプロイが推奨されている
  - ロールバックとかを考えると、本当はs3デプロイのほうがよいようだ
