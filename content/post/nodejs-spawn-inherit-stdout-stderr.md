---
title: "nodejsで標準入出力/エラーを共有した子プロセスを作る"
date: 2020-02-14T11:26:41+09:00
draft: false
author: sakamossan
---

cloudrunを使う際に必要になった

cloudrunはhttpエンドポイントから処理がキックされるので、コンテナでbashコマンドを実行したいときはnodejsのhttpサーバの子プロセスがスクリプトを実行するという形になる(つかいにくい)

子プロセスの出力をログとしてstackdriverに流したいので、nodejsで標準入出力/エラーを共有した子プロセスを作る必要があった

## コード

こんなコードを書いて動作確認

- `$ node index.js out` などで親プロセスを起動
- サブコマンドごとに子プロセスが以下の動作
  - 標準出力を吐いて終了
  - エラー出力を吐いて終了
  - 異常終了

```js
const { spawn } = require('child_process');

const pSpawn = (command, args, options) => new Promise((resolve, reject) => {
  const childProcess = spawn(command, args, options);
  childProcess.on('exit', code => code ? reject(code) : resolve(code));
});

(async () => {
  const subcommand = process.argv[2];
  const promise = pSpawn('./entrypoint.sh', [subcommand], {
    env: process.env,
    cwd: __dirname,
    stdio: 'inherit',
  });
  let exitCode;
  try {
    exitCode = await promise
  } catch (error) {
    exitCode = error;
  }
  console.log(`exitCode: ${exitCode}`);
})();
```

#### entrypoint.sh

```bash
#!/bin/bash
set -eu
scase "$1" in
  out)
    shift
    echo "one!"
    ;;
  err)
    shift
    perl -E 'warn "two"'
    ;;
  die)
    shift
    exit 77
    ;;
esac
```

## 動作

期待通りに動作した

- stdoutはstdoutに
- stderrはstderrに
- exitcodeが0でないときはrejectされた

```console
$ node index.js out
one!
exitCode: 0
# エラー出力を確認する
$ node index.js err 1>/dev/null
two at -e line 1.
$ node index.js die
exitCode: 77
```

---

以下は実装時のメモ

### spawnのstdio引数

```js
pSpawn('./entrypoint.sh', [subcommand], {
    env: process.env,
    cwd: __dirname,
    stdio: 'inherit',
  });
```

この`stdio`引数で標準出力/エラー出力を制御している

- [Child Process | Node.js v13.8.0 Documentation](https://nodejs.org/api/child_process.html#child_process_child_process_spawn_command_args_options)

`stdio: 'inherit'` で今回やりたい動作にできる

> 'inherit': Pass through the corresponding stdio stream to/from the parent process. In the first three positions, this is equivalent to process.stdin, process.stdout, and process.stderr, respectively. In any other position, equivalent to 'ignore'.


### pSpawn

```js
const pSpawn = (command, args, options) => new Promise((resolve, reject) => {
  const childProcess = spawn(command, args, options);
  childProcess.on('exit', code => code ? reject(code) : resolve(code));
});
```

毎回 `on.('exit')` などを書きたくないのでヘルパー

- spawnと引数は一緒
- ただし異常終了した場合はexitcodeをrejectする

pidが欲しい場合などはちゃんとしたのをつかうのがよい

- [patrick-steele-idem/child-process-promise: Simple wrapper around the "child_process" module that makes use of promises](https://github.com/patrick-steele-idem/child-process-promise)
