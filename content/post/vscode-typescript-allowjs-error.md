---
title: "Cannot write file ... because it would overwrite input file."
slug: vscode-typescript-allowjs-error
date: 2019-05-18T12:31:40+09:00
draft: false
author: sakamossan
---

typescriptのプロジェクトで開発中VSCodeでエラーメッセージが出た

> Error "Cannot write file ... because it would overwrite input file."

ファイルがすでに存在しているので書き出せないとのこと

確かにコンパイルし直そうとすると同じエラーが出る

```console
$ $(npm bin)/tsc
error TS5055: Cannot write file '..../handler.js' because it would overwrite input file.
...
```

### 原因

`allowJs` オプションがたっていると出てしまうもののようだ
おそらくこのオプションがたっているtscには、typescriptの成果物としてのjsファイルと、ソースコードのjsファイルの区別がつかなくなってしまうため掲題のようなエラーを吐くのだろう


### 解決

警告になっているファイルたちを消したら警告はなくなった

```console
$ rm -rf ./build
```

おそらく出力先のディレクトリと、ソースコードのディレクトリをきちんと別なものを指定するのが正しいが、VSCodeの警告を止めるだけならこれでよかった

### 参考

- [visual studio - Typescript error "Cannot write file ... because it would overwrite input file." - Stack Overflow](https://stackoverflow.com/questions/42609768/typescript-error-cannot-write-file-because-it-would-overwrite-input-file)
- [Error "Cannot write file ... because it would overwrite input file." · Issue #27436 · microsoft/TypeScript](https://github.com/Microsoft/TypeScript/issues/27436)
