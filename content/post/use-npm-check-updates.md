---
title: "package.json の deps を深く考えずに全部upgradeする"
date: 2020-01-11T16:34:44+09:00
draft: false
---

以下のコマンドでできる

```bash
$ npx npm-check-updates --upgrade
```

いちおうどんなアップグレードになるかは事前に確認できる

```bash
$ npx npm-check-updates 
```

その他のオプションもいろいろある

```bash
$ npx npm-check-updates --help
npx: 259個のパッケージを8.35秒でインストールしました。
Usage: ncu [options] [filter]

[filter] is a list or regex of package names to check (all others will be ignored).

Options:
  --configFilePath <path>      rc config file path (default: directory of `packageFile` or ./ otherwise)
  --configFileName <path>      rc config file name (default: .ncurc.{json,yml,js})
  --cwd <path>                 Used as current working directory for `spawn` in npm listing
  --dep <dep>                  check only a specific section(s) of dependencies: prod|dev|peer|optional|bundle (comma-delimited)
  -e, --error-level <n>        set the error-level. 1: exits with error code 0 if no errors occur. 2: exits with error code 0 if no packages need updating (useful for continuous integration). Default is
                               1. (default: 1)
  --engines-node               upgrade to version which satisfies engines.node range
  -f, --filter <matches>       include only package names matching the given string, comma-or-space-delimited list, or /regex/
  -g, --global                 check global packages instead of in the current project
  -i, --interactive            Enable interactive prompts for each dependency; implies -u unless one of the json options are set
  -j, --jsonAll                output new package file instead of human-readable message
  --jsonDeps                   Will return output like `jsonAll` but only lists `dependencies`, `devDependencies`, and `optionalDependencies` of the new package data.
  --jsonUpgraded               output upgraded dependencies in json
  -l, --loglevel <n>           what level of logs to report: silent, error, minimal, warn, info, verbose, silly (default: warn) (default: "warn")
  -m, --minimal                do not upgrade newer versions that are already satisfied by the version range according to semver
  -n, --newest                 find the newest versions available instead of the latest stable versions
  -p, --packageManager <name>  npm (default) or bower (default: "npm")
  --packageData                include stringified package file (use stdin instead)
  --packageFile <filename>     package file location (default: ./package.json)
  --pre <n>                    Include -alpha, -beta, -rc. Default: 0. Default with --newest and --greatest: 1
  --prefix <path>              Used as current working directory in bower and npm
  -r, --registry <url>         specify third-party npm registry
  --removeRange                remove version ranges from the final package version
  -s, --silent                 don't output anything (--loglevel silent)
  --semverLevel <level>        find the highest version within "major" or "minor"
  -t, --greatest               find the highest versions available instead of the latest stable versions
  --timeout <ms>               a global timeout in ms
  -u, --upgrade                overwrite package file
  -x, --reject <matches>       exclude packages matching the given string, comma-or-space-delimited list, or /regex/
  -v, --version                4.0.1
  -V
  -h, --help                   output usage information
```
