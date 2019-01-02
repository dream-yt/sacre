---
title: "bigqueryで200MBまでしか探索(課金)させないbqコマンドのオプション"
date: 2019-01-02T16:15:20+09:00
draft: false
---

2つオプションがあって、それらを使うとそれ以上課金されそうなコマンドはエラーで終了してくれる

### `--maximum_billing_tier`

これは `単価` という単位を渡せるオプション

例えば1を指定すると1TBまでしか探索しないようになる

> BigQuery のクエリー単価には階層があり、これを「料金階層（Billing Tier）」と呼びます。クエリー単価は、この料金階層と基本単価により決まります（基本単価 x 料金階層）。なお、料金階層は、正の整数で表されます。

- [BigQuery の料金階層と High-Compute クエリー | MAGELLAN BLOCKS](https://www.magellanic-clouds.com/blocks/guide/bq-billing-tier-and-high-compute-query/)

あんまり直感的じゃない(初見ではオプションに渡す値でどれくらいの課金が発生するのか分からない)ので無理にこっちを使うことはなさそう

### `--maximum_bytes_billed=100000000`

こっちはbyte数で指定できる。 `maximum_billing_tier` では1TB以下の指定が出来ないようだが、こちらはbyte単位なので小さい値が設定できる
軽い確認などでバカバカクエリを投げる時は200MBとかに指定しておくと安心

```bash
$ bq --maximum_bytes_billed=200000000 query "$(cat /tmp/_.sql)"
```

ちなみに `--maximum_bytes_billed=200MB` みたいな指定は出来ない

## その他

関係ないけどメモ

- パーティションドテーブルを使っている場合はlegacysqlが使えない
- 明示的に `--nouse_legacy_sql` オプションをつける必要がある

```bash
$ bq query --nouse_legacy_sql "$(cat /tmp/_.sql)"
```
