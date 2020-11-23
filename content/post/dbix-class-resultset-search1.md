---
title: "perlのDBIx::Class::ResultSetでちょい手の込んだSELECTの例1"
slug: dbix-class-resultset-search1
date: 2019-04-08T18:43:30+09:00
draft: false
author: sakamossan
---

- searchメソッドはすごい色々できるので覚えきれない
- 特に第二引数のハッシュに渡せるものがすごい色々できる

```perl
$tab1_resultset->search(
    {
        # 1つ目の引数は検索条件
        'tab1.id' => $id,
        'okok.status' => STATUS_NOTYET
    },
    {
        # SQLでいう射影部分 (カラム名とalias)
        '+select' => [
            'tab1.name',
            \'COUNT(1)',
            \'MIN(okok.created)'
        ],
        '+as' => [qw/
            tab_name
            count
            earliest_created
        /],
        # resultsetクラスで定義したrelationの名前を書く (テーブル名そのままではない)
        join => ['okok', 'qr'],
        # 自resultsetクラスはmeで表す
        group_by => ['me.id'],
        order_by => [
            # 集計など、文字列をそのまま埋めたい場合はstringのrefをとる (injection注意)
            { -desc => \'MIN(DATE(qr.created))' },
            { -desc => \'COUNT(1)' }
        ]
    }
);
```


### 参考

- [DBIx::Class::ResultSet - Represents a query used for fetching a set of results. - metacpan.org](https://metacpan.org/pod/distribution/DBIx-Class/lib/DBIx/Class/ResultSet.pm#search_rs)
- [DBIx::Class::Manual::Cookbook - Miscellaneous recipes - metacpan.org](https://metacpan.org/pod/distribution/DBIx-Class/lib/DBIx/Class/Manual/Cookbook.pod#SEARCHING)
