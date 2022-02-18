---
title: "ディレクトリの中を再帰的に探して条件にあうファイルを見つける"
slug: walk-fs-files-with-nodejs
date: 2022-02-18T19:02:11+09:00
draft: false
author: sakamossan
---

`@nodelib/fs.walk` というパッケージで walk できる。が、Promise に対応していないのでラッパーを用意して使うことにした。

```ts
import type { Entry } from "@nodelib/fs.walk";
import fsp from "node:fs/promises";
import * as fsWalk from "@nodelib/fs.walk";

export type File = {
  path: string;
  content: string;
};

export const collectFile = async (
  dirpath: string,
  filterFn: (entry: Entry) => any = () => true
): Promise<File[]> => {
  const entries: Entry[] = await new Promise((resolve, reject) => {
    fsWalk.walk(dirpath, (error, entries) => {
      if (error) {
        reject(`collectFile failed to walk: ${error}`);
      }
      resolve(
        entries.flatMap((entry) =>
          !entry.dirent.isDirectory() &&
          !entry.dirent.isSymbolicLink() &&
          await filterFn(entry)
            ? entry
            : []
        )
      );
    });
  });
  return Promise.all(
    entries.map(async (entry) => {
      const data = await fsp.readFile(entry.path);
      return {
        content: data.toString(),
        path: entry.path,
      };
    })
  );
};
```

## 参考

- [nodelib/packages/fs/fs.walk at master · nodelib/nodelib](https://github.com/nodelib/nodelib/tree/master/packages/fs/fs.walk)
