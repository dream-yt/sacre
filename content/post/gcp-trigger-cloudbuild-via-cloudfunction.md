---
title: "CloudFunction で CloudBuild をトリガーする "
date: 2020-06-01T16:31:19+09:00
draft: false
---

まずgcloudで既存のトリガーの一覧を確認しておく

```yaml
$ gcloud beta builds triggers list
---
createTime: '2020-05-06T13:01:33.647678872Z'
description: master ブランチへの push
filename: site/cloudbuild.yaml
github:
  name: test
  owner: admin
  push:
    branch: ^master$
id: 0e2bd416-129f-44a3-b7ed-79c3c61e021a
name: master-push-trigger
tags:
- github-default-push-trigger
```

## nodejsで呼び出し

cloudbuildの公式npmパッケージがある

- [googleapis/nodejs-cloudbuild: Cloud Build API client for Node.js](https://github.com/googleapis/nodejs-cloudbuild)

こんな感じでビルドをトリガーできる

```js
import { CloudBuildClient } from '@google-cloud/cloudbuild';

const projectId = 'testproject-531612';
// gcloudで調べたidを入れる
const triggerId = '0e2bd416-129f-44a3-b7ed-79c3c61e021a'
const credentials = require('./credentials/cloudbuild-trigger.json');
const cloudbuild = new CloudBuildClient({ credentials });
const source = {
  projectId,
  dir: './',
  branchName,
};
await cloudbuild.runBuildTrigger({ projectId, triggerId, source });
```
