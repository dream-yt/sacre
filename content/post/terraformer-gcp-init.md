---
title: "GCP のプロジェクトで Terraformer を使ってみる"
slug: terraformer-gcp-init
date: 2022-03-06T18:05:38+09:00
draft: false
author: sakamossan
---

## インストール

インストールまでは brew でできる。 terraform 自体のバージョンとの互換性をちゃんとしておいた方がよさそうなので、tfenv でサポート対象のバージョンを入れておく。

```
$ which terraformer
/usr/local/bin/terraformer
$ terraform version
Terraform v0.13.7
```

## 下準備

前もって準備をすることがいくつかある。


### plugin をコピーしておく

> 2022/03/06 17:15:19 open ~/.terraform.d/plugins/darwin_amd64: no such file or directory

> 利用する前にディレクトリ(~/.terraform.d/plugins/{darwin,linux}_amd64/)を作成し、ここにプロバイダをインストールしておく必要があります。

- [TerraformerのためのTerraformer - Qiita](https://qiita.com/donko_/items/a69fc28109c2b59f3831#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)

ここから最新のプロバイダをもってきて使う

- [terraform-provider-google Versions | HashiCorp Releases](https://releases.hashicorp.com/terraform-provider-google/)


### APIを有効にする

Compute Engine を使っていない場合でも Compute Engine API を有効にしておく必要がある。有効にしていないと実行時に以下のようなエラーがでる。

> 2022/03/06 17:29:48 googleapi: Error 403: Compute Engine API has not been used in project 123456789101 before or it is disabled. Enable it by visiting https://console.developers.google.com/apis/api/compute.googleapis.com/overview?project=123456789101 then retry. If you enabled this API recently, wait a few minutes for the action to propagate to our systems and retry.


## 実行

```bash
$ terraformer import google --resources=bigQuery,gcs,logging,project,cloudFunctions,iam,pubsub --projects=$GCP_PROJECT_ID
```

以下のようにファイルが生成される。

```console
$ tree
.
└── generated
    └── google
        └── proj-123456
            ├── bigQuery
            │   └── global
            │       ├── bigquery_dataset.tf
            │       ├── bigquery_table.tf
            │       ├── outputs.tf
            │       ├── provider.tf
            │       └── terraform.tfstate
            ├── cloudFunctions
            │   └── global
            │       ├── provider.tf
            │       └── terraform.tfstate
            ├── gcs
            │   └── global
            │       ├── outputs.tf
            │       ├── provider.tf
            │       ├── storage_bucket.tf
            │       ├── storage_bucket_acl.tf
            │       ├── storage_bucket_iam_binding.tf
            │       ├── storage_bucket_iam_policy.tf
            │       ├── storage_default_object_acl.tf
            │       └── terraform.tfstate
            ├── iam
            │   └── global
            │       ├── outputs.tf
            │       ├── project_iam_member.tf
            │       ├── provider.tf
            │       ├── service_account.tf
            │       └── terraform.tfstate
            ├── logging
            │   └── global
            │       ├── provider.tf
            │       └── terraform.tfstate
            ├── project
            │   └── global
            │       ├── outputs.tf
            │       ├── project.tf
            │       ├── provider.tf
            │       └── terraform.tfstate
            └── pubsub
                └── global
                    ├── provider.tf
                    └── terraform.tfstate
```


## 感想

生成されるコードのリソース名などはヒューマンリーダブルではない。「terraformer import したコードをもとにして terraform 化をしていくためのツール」という話かなと思っていたので少し勘違いをしていた。

```console
$ head -1 ./generated/google/proj-123456/iam/global/project_iam_member.tf
resource "google_project_iam_member" "tfer--roles-002F-cloudbuild-002E-builds-002E-builderserviceAccount-003A-123456789101-0040-cloudbuild-002E-gserviceaccount-002E-com" {

```

「生成されたコードをもとに tf ファイルを育てていく」という使い方ではなく、「tfファイルを実装するために参考にするコードを履くツール」のようだ。


## 参考

- [清掃員がGCP環境構築をTerraform化してみた｜Blog｜株式会社COLSIS（コルシス）](https://colsis.jp/blog/gcpterraform/)
- [terraformer/gcp.md at master · GoogleCloudPlatform/terraformer](https://github.com/GoogleCloudPlatform/terraformer/blob/master/docs/gcp.md)
- [TerraformでGoogle Cloudを扱うためのローカル端末環境構築 | DevelopersIO](https://dev.classmethod.jp/articles/accesse-google-cloud-with-terraform/)
