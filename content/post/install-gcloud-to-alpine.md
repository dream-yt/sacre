---
title: "alpine に gcloud をインストールする Dockerfile"
slug: install-gcloud-to-alpine
date: 2020-02-21T09:23:30+09:00
draft: false
author: sakamossan
---

- curl, bash, python, が必要
- PATHを通す (root配下にインストールされた)

```dockerfile
FROM node:10-alpine

RUN apk --no-cache add curl bash python
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin
```

## 参考

- [How to install the Google Cloud SDK in a Docker Image? - Stack Overflow](https://stackoverflow.com/questions/28372328/how-to-install-the-google-cloud-sdk-in-a-docker-image)
- [Push an image on google cloud - Docker Hub - Docker Forums](https://forums.docker.com/t/push-an-image-on-google-cloud/7538)

