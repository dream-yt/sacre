---
title: "git bisect を使う"
slug: git-bisect-101
date: 2020-09-03T10:50:22+09:00
draft: false
author: sakamossan
---

たくさんコミットしてて、気がついたら関係なさそうなUIが動かなくなっていた場合など、
どのコミットが原因で動かなくなったかを割り出すのに git bisect が便利。

## 始める

以下のコミットで bisectモードに入れる。叩いたらすぐに真ん中のコミットがチェックアウトされる。

```
git bisect start <うごかないHASH> <うごくHASH>
```

### チェックアウトされたコードでうごく場合

動作確認したらgood/badをやると次の二分探索先のハッシュがチェックアウトされる

```
git bisect good
```

### 動かない場合

```
git bisect bad
```

## 終わり

途中で分かったり、abortしたくなった場合は reset 

```
git bisect reset
```


## 参考

- [git bisect で問題箇所を特定する - Qiita](https://qiita.com/usamik26/items/cce867b3b139ea5568a6)

本来だとテストスクリプトとかを登録して使うが、テストがあるときはgit bisectは使わないで済むことが多い。
