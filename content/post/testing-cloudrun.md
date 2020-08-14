---
title: "Cloud Runの動作確認 (イメージのビルド、デプロイと削除)"
date: 2020-02-12T08:29:32+09:00
draft: false
author: sakamossan
---

- [システム パッケージのチュートリアルを使用する  |  Cloud Run  |  Google Cloud](https://cloud.google.com/run/docs/tutorials/system-packages)

`$ gcloud builds submit` を叩くと、Dockerfileをもとにビルドが始まる

```console
$ gcloud builds submit --tag gcr.io/$GOOGLE_PROJECT_ID/graphvizn

... snip ...

10-alpine: Pulling from library/node
c9b1b535fdd9: Already exists
0188bce71676: Pulling fs layer
f62af20101b7: Pulling fs layer
1bffdb76255c: Pulling fs layer
1bffdb76255c: Download complete
f62af20101b7: Verifying Checksum
f62af20101b7: Download complete
0188bce71676: Verifying Checksum
0188bce71676: Download complete
0188bce71676: Pull complete
f62af20101b7: Pull complete
1bffdb76255c: Pull complete
Digest: sha256:ca59a7a6abfdfe8f2fb62b14c24be5eac33a0acda20fd3d5e5bf2a942de57bad
Status: Downloaded newer image for node:10-alpine
 ---> 955e0e1f1a41
Step 2/9 : WORKDIR /usr/src/app
 ---> Running in e54837b13a43
Removing intermediate container e54837b13a43
 ---> 8de69a28fa7b
Step 3/9 : RUN apk --no-cache add graphviz ttf-ubuntu-font-family
 ---> Running in fa8a10c00d92
fetch http://dl-cdn.alpinelinux.org/alpine/v3.11/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.11/community/x86_64/APKINDEX.tar.gz
(1/35) Installing libxau (1.0.9-r0)
(2/35) Installing libbsd (0.10.0-r0)

... snip ...

4bc9914fb50e: Pushed
latest: digest: sha256:0000df6c3d9f6c6f5a2876eccfcd4ebff014022d41b2e069a9108ccad9c0a532 size: 2207
DONE
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

ID                                    CREATE_TIME                DURATION  SOURCE                                                                                    IMAGES                                     STATUS
959f914d-b05f-43c1-a1e7-1a66d4f080c6  2020-02-11T22:49:37+00:00  35S       gs://testes123456_cloudbuild/source/1581461344.82-4ddc74bd5d524f54ba32577e2c06d110.tgz  gcr.io/mcskpjt-192612/graphvizn (+1 more)  SUCCESS
```

`run deploy` でimageを指定してデプロイ

```bash
$ gcloud beta run deploy graphviz-web2 \
  --platform managed \
  --no-allow-unauthenticated \
  --region asia-northeast1 \
  --image gcr.io/mcskpjt-192612/graphvizn@sha256:0000df6c3d9f6c6f5a2876eccfcd4ebff014022d41b2e069a9108ccad9c0a532
```

`run services delete` で削除

```bash
$ gcloud beta run services delete \
  --platform managed \
  --region asia-northeast1 graphviz-web2
```
