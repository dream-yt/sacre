---
title: "Start Gcp Free Instance"
date: 2019-12-25T00:13:24+09:00
draft: false
---

# gcpで無料のインスタンスを立ち上げてsshするまで

### gcpアカウントのセットアップ

```bash
$ gcloud config set project penguin-xxxxxxxxxx
$ gcloud config set account penguin@gmail.com
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
