---
title: "serverless deploy を amazonlinuxイメージで行う"
slug: serverless-deploy-from-docker-container
date: 2019-08-05T11:32:41+09:00
draft: false
author: sakamossan
---

lambdaとnodeのネイティブモジュール周りで辛いことになった時用


## Dockerfile

```dockerfile
FROM amazonlinux:latest

RUN curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo > /etc/yum.repos.d/yarn.repo
RUN curl --silent --location https://rpm.nodesource.com/setup_10.x | bash
RUN yum install -y nodejs gcc-c++ make git yarn
RUN yarn global add serverless --silent --no-progress

RUN mkdir /app
WORKDIR /app

ADD package.json /app/package.json
ADD yarn.lock /app/yarn.lock
# build用なのでdevDepsも必要
RUN yarn install --silent --no-progress --frozen-lockfile

ADD . /app
CMD ["/bin/bash", "-c", "node --version; yarn --version; serverless --version"]
```

## .dockerignore

```bash
node_modules
.webpack
# AWSトークンなどの管理用
.envrc
```

## slsw.sh

```bash
#!/bin/bash

docker build -t sls-amzn-build .
docker run -it \
  --env AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" \
  --env AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" \
  sls-amzn-build:latest serverless $@
```

#### eg

```
slsw.sh logs --function MyFunc --stage dev
slsw.sh deploy --stage dev
```
