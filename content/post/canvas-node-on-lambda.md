---
title: "node-canvasをlambdaで動かす"
date: 2019-06-22T13:00:03+09:00
draft: false
author: sakamossan
---

node-canvasは内部でネイティブモジュールを使用しているため、macos上でコンパイルしたものをlambdaにアップロードしても動作しない。AmazonLinux上でコンパイルしたものをlambdaへアップロードすることになる。


## 手順

- Dockerfile作成
- docker run で yarn install を実行する
  - AmazonLinuz上でコンパイルする
  - ボリュームをマウントして macos で node_modules を受け取る
- zip して lambda にアップロード



## Dockerfile作成

こちらから拝借

- [node-canvas error | gist.github.com/jakelazaroff](https://gist.github.com/jakelazaroff/29e3e6d81c6cba1c6a8a10c09324c888)

```dockerfile
FROM amazonlinux:latest

RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
RUN yum install -y nodejs zip
RUN npm install -g yarn

RUN mkdir /build
COPY ./package.json /build/
COPY ./yarn.lock /build/

WORKDIR /build

ENTRYPOINT ["yarn"]
CMD ["install"]
```

なお、nodeのversionを10系にするとuuidがstatic linkされてないとのことで動かなかった


### docker build

```bash
$ docker build -t lambda-build .
```


## docker run -v

buildディレクトリを作成して、そこに作ってもらう

```bash
$ mkdir build
$ docker run -v $(pwd)/build/node_modules:/build/node_modules lambda-build
```

```console
$ ll ./build/node_modules/ | head
total 32
drwxr-xr-x  75 sakamossan  staff   2.3K  6 22 12:30 .
drwxr-xr-x   4 sakamossan  staff   128B  6 22 12:31 ..
drwxr-xr-x  10 sakamossan  staff   320B  6 22 12:30 .bin
-rw-r--r--   1 sakamossan  staff    15K  6 22 12:30 .yarn-integrity
drwxr-xr-x   6 sakamossan  staff   192B  6 22 12:30 abbrev
drwxr-xr-x   6 sakamossan  staff   192B  6 22 12:30 ansi-regex
drwxr-xr-x   6 sakamossan  staff   192B  6 22 12:30 aproba
drwxr-xr-x  11 sakamossan  staff   352B  6 22 12:30 are-we-there-yet
drwxr-xr-x   7 sakamossan  staff   224B  6 22 12:30 balanced-match
```


## zip して lambda にアップロード

```bash
$ cd ./build
$ cp ../handler.js .
$ zip ~/Desktop/function.zip -r *
$ aws lambda update-function-code \
    --function-name chart-endpoint-dev-ChartEndpoint \
    --zip-file fileb://~/Desktop/function.zip
```

アップロードの部分はawscliでなく、serverlessを使った方がよさそう
serverless deploy には zipファイルを指定できるようだ

```
$ serverless deploy --help  | grep package
    --package / -p ..................... Path of the deployment package
```


## 動作確認

requireしたcanvasオブジェクトをJSONにしたものを返すとこんな感じ

```bash
$ serverless invoke --function ChartEndpoint | jq -r .body | jq .
```

```json
{
  "canvas": {
    "backends": {},
    "version": "2.5.0",
    "cairoVersion": "1.16.0",
    "jpegVersion": "6b",
    "gifVersion": "5.1.4",
    "freetypeVersion": "2.9.1"
  },
  "input": {}
}
```
