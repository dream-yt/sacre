---
title: "Start Gcp Free Instance"
slug: start-gcp-free-instance
date: 2019-12-25T00:13:24+09:00
draft: false
author: sakamossan
---

# gcpで無料のインスタンスを立ち上げてsshするまで

### gcpアカウントのセットアップ

```bash
$ gcloud config configurations create okokng
$ gcloud config set project okokng-xxxxxxxxxx
$ gcloud config set account okokng@gmail.com
$ gcloud auth login
```

ブラウザが立ち上がるのでログイン


### インスタンスの立ち上げ

f1-microをUSリージョンで立てる分には無料

```bash
$ gcloud compute instances create island \
    --image-family ubuntu-1804-lts \
    --image-project gce-uefi-images \
    --machine-type f1-micro \
    --zone us-east1-b \
    --metadata-from-file startup-script=./startup-script.sh
```

### インスタンスへのログイン

```bash
$ gcloud compute ssh root@island --zone us-east1-b
```

### スタートアップスクリプトのログをtail

```bash
$ tail -F /var/log/syslog
```
