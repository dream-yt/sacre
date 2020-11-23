---
title: "perlの正規表現、e(eval)オプション"
slug: perl-regexp-eval-modifier
date: 2019-03-19T17:12:58+09:00
draft: false
author: sakamossan
---

eオプションをつけるとマッチした箇所に好きな処理が書けて便利

> e  - evaluate the right-hand side as an expression

たとえば以下はurlっぽい文字列をaタグに変換するサンプル

```perl
my $url2link = sub {
    my $url = shift;
    my $render_url = length $url > 40 ? substr($url, 0, 40) . q(...) : $url;
    qq(<a target='_blank' href='$url'>$render_url</a>);
};
$note =~ s/(https?:\/\/[a-zA-Z0-9.\-_\@:\/~?%&;=+#',()*!]+)/$url2link->("$1")/eg;
```

サンプルについてるgオプションはglobal

> g  - globally match the pattern repeatedly in the string

### 注意点

##### eオプションで置換部分に色々処理を書こうとすると、syntax error になる

- 構文的に使えない文字があるかも?
- サンプルの処理は、置換部分に置くと構文エラーになるので `$url2link` を関数に切り出している

##### `$1` を使いたいときはちゃんと正規表現でキャプチャしておく

- `$&` を使うとパフォーマンス上の問題になるので使わない
    - [Perlの組み込み変数 $& の翻訳 - perldoc.jp](http://perldoc.jp/variable/%24%26)


## 参考

- [perlre - perldoc.perl.org](https://perldoc.perl.org/perlre.html)
