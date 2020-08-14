---
title: "vscodeからdockerコンテナ内でperl -wcして文法チェック"
date: 2018-12-12T08:12:58+09:00
draft: false
author: sakamossan
---

こちらを使うと簡単に出来た

- [henriiik/vscode-docker-linter: Lint the things in your docker containers](https://github.com/henriiik/vscode-docker-linter)

## 設定

設定項目もこれくらいで済む

```json
"docker-linter.perl.enable": true,
"docker-linter.perl.machine": "",  // "default"だとdocker-machineを使おうとする
"docker-linter.perl.container": "app_app_1",
"docker-linter.perl.command": "carton exec perl -wc -Ilib -It/lib "
```


#### `docker-linter.perl.container`

`docker ps` した、端っこの `NAMES` カラムを指定する

```
$ docker ps | perl -aF'\s+' -nlE 'say $F[-1]'
```


#### `docker-linter.perl.command`

lint用のコマンドを渡す
プロジェクトごとに依存先などは違うはずなので個別で設定するもの

`docker exec` に渡してlintする場合と同じようなものを渡せば良い

```
$ carton exec perl -wc -Ilib -It/lib
```


---

サンプルの設定があって、参考になった

- [vscode-docker-linter/settings.json at master · henriiik/vscode-docker-linter](https://github.com/henriiik/vscode-docker-linter/blob/master/playground-perl/.vscode/settings.json)

