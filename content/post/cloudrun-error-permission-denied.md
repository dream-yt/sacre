---
title: "ERROR: (gcloud.beta.run.deploy) PERMISSION_DENIED"
date: 2020-02-17T09:08:49+09:00
draft: false
---

CloudRunのデプロイ時にこんなログが出た

> ERROR: (gcloud.beta.run.deploy) PERMISSION_DENIED: Permission denied on 'locations/asia-northeast1-a' (or it may not exist)

フル権限のユーザで作業しているはずなので `PERMISSION_DENIED` といわれても原因がピンとこない。しかしこれは単にregionの指定が間違っているだけである(locationと間違っていた)

- ❌ `--region asia-northeast1-a`
- ⭕️ `--region asia-northeast1`
