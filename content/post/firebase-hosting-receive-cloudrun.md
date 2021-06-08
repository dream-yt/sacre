---
title: "Firebase Hosting の一部のエンドポイントを CloudRun で受ける"
slug: firebase-hosting-receive-cloudrun
date: 2021-06-08T22:37:21+09:00
draft: false
author: sakamossan
---

こんな設定でできる。CloudFunctionで受けるのとほとんど一緒。

```json
{
  "hosting": {
    "public": "public",
    "rewrites": [
      {
        "source": "/**",
        "run": {
          "serviceId": "myappcloudrun-servicename",
          "region": "asia-northeast1"
        }
      }
    ]
  }
}
```

## 参考

- [ホスティング動作を構成する  |  Firebase](https://firebase.google.com/docs/hosting/full-config?hl=ja#direct_requests_to_a_cloud_run_container)
