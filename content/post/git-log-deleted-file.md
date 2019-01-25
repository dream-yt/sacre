---
title: "特定のファイルを消したコミットを確認する"
date: 2019-01-25T13:49:58+09:00
draft: false
---

以下のコマンドで確認できる

```
$ git log --diff-filter=D -- path/to/targetfile.pl
```

`--` 以降にファイル名を渡すとそのファイルの履歴だけ見ることが出来る

```
        [--] <path>...
            Show only commits that are enough to explain how the files that
            match the specified paths came to be. See History Simplification
            below for details and other simplification modes.

            Paths may need to be prefixed with -- to separate them from options
            or the revision range, when confusion arises.
```

`--diff-filter` オプションはファイル操作ごとのフィルタを提供している

```
$ git log --help | grep -A20 diff-filter
       --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]
            Select only files that are Added (A), Copied (C), Deleted (D),
            Modified (M), Renamed (R), have their type (i.e. regular file,
            symlink, submodule, ...) changed (T), are Unmerged (U), are Unknown
            (X), or have had their pairing Broken (B). Any combination of the
            filter characters (including none) can be used. When *
            (All-or-none) is added to the combination, all paths are selected
            if there is any file that matches other criteria in the comparison;
            if there is no file that matches other criteria, nothing is
            selected.

            Also, these upper-case letters can be downcased to exclude. E.g.
            --diff-filter=ad excludes added and deleted paths.

            Note that not all diffs can feature all types. For instance, diffs
            from the index to the working tree can never have Added entries
            (because the set of paths included in the diff is limited by what
            is in the index). Similarly, copied and renamed entries cannot
            appear if detection for those types is disabled.

```
