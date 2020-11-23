---
title: "jsでマルチバイト文字にあてる正規表現はuフラグをつける"
slug: js-multibyte-regex-uflag
date: 2020-08-03T10:19:16+09:00
draft: false
author: sakamossan
---

## 理由

- jsの文字列は内部でUTF-16を使っている
- jsで文字列の1文字は1つのコードユニットを指し、コードポイントを指すわけではない

## 例

`👶🏼.length`はJSだと4である

```js
> const baby = "👶🏼"
undefined
> baby.length
4
```

なので以下の「4文字」という正規表現にマッチしてしまう

```js
> baby.match(/^.{4}$/)
[ '👶🏼', index: 0, input: '👶🏼', groups: undefined ]
```

これを避けるためには(`👶🏼`を1文字として扱うためには)
正規表現に`u`フラグをつける

```js
> baby.match(/^.{4}$/u)
null
```

## 参考

- [文字列とUnicode · JavaScript Primer #jsprimer](https://jsprimer.net/basic/string-unicode/)

> 基本的には正規表現にuフラグをつけて問題となるケースは少ないはずです。 なぜなら、サロゲートペアの片方だけにマッチしたい正規表現を書くケースはまれであるためです。


## その他

例にあげた `👶🏼` だと異体字セレクタの話が混ざってるのでそれはまた今度
