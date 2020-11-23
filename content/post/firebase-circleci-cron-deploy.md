---
title: "circleciのcronトリガーでfirebase/hostingをアップデートする"
slug: firebase-circleci-cron-deploy
date: 2019-11-04T14:26:47+09:00
draft: false
author: sakamossan
---

こんな前提の場合の設定

- 静的サイトをfirebase/hostingに置いている
- circleciのjob上 (dockerコンテナ内) でサイトの更新をしたい
- 日毎で毎日決まった時間に更新したい


## circleci上で定時実行する

- `.circleci/config.yaml` にこんなworkflowを書く
- この設定で `yarn install && yarn run release` が毎日2時になったら実行される

```yaml
workflows:
  daily:
    jobs:
      - update
    triggers:
      - schedule:
          # UTCで記述 (JST14時)
          cron: "0 5 * * *"
          filters:
            branches:
              only:
                - master
jobs:
  # `workflows.daily.jobs` に定義したのと同じ名前
  update:
    docker:
      - image: circleci/node:10.15
    steps:
      - checkout
      - run:
          command: yarn install
          working_directory: functions/example.com
      # このコマンドの中で firebase deploy を叩いている (後述)
      - run:
          command: yarn run release
          working_directory: functions/example.com
```

## firebaseへのデプロイ

`yarn run release` をしている package.json はこんな感じ

```json
  "scripts": {
    "build": "gatsby build",
    "deploy:ci": "firebase deploy --token 'xxxxxxxxxxxxxxxxxxxx'",
    "release": "yarn run build && yarn run deploy:ci",
  }
```

#### `firebase deploy --token`

firebase は ci上でデプロイをするためのトークンを発行することができる  
こんなコマンドで払い出すことができる (実行するとブラウザが立ち上がって認証画面に行く)

```bash
$ npx firebase login:ci
```


## 参考

- [Firebase Hosting - Deploying to Firebase Hosting - Deploying a Gatsby site | CircleCI](https://circleci.com/blog/automatically-deploy-a-gatsby-site-to-firebase-hosting/)
- [Circle-CI 2.0のcron triggerを使って、定期実行をする - Qiita](https://qiita.com/terrierscript/items/55b6bbfbc064e80c1349)
