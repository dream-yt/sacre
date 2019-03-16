---
title: "swiftのメソッドに出てくる _ と #"
date: 2019-03-16T13:01:39+09:00
draft: false
---

以下のバージョンのreplで動かした

```console
$ swift -v
Apple Swift version 4.2.1 (swiftlang-1000.11.42 clang-1000.11.45.1)
```

## 前提

### ラベル名が必要

- もともとswiftではメソッド/関数には呼ぶときに引数と一緒にラベル名も渡す必要がある
- 渡さないとコンパイルエラーになる

```swift
func add(a: Int8, b: Int8, c: Int8) -> Int8 {
  return a + b + c;
}
add(1, 2, 3)  // コンパイルエラー
add(a:1, b: 2, c: 3)  // OK
```

### 外部参照用のラベルと、内部参照のラベルが設定できる

- 引数ラベルの前にさらにラベルを置ける
- 関数を呼ぶ時にはこっちのラベル(外部参照用のラベル)をわたす
- 関数の内部では内部参照のラベル(というか変数名)で処理を書く

```swift
func add(oa a: Int8, ob b: Int8) -> Int8 {
  return a + b;
}
add(oa: 1, ob: 2)  // OK
add(a: 1, ob: 2)   // コンパイルエラー
```

## _

- `_` をつけると呼ぶときにラベル名がいらなくなる
- `_` は引数名の前につける

```swift
func add(_ a: Int8, _ b: Int8, c: Int8) -> Int8 {
  return a + b + c;
}
add(1, 2, c: 3)  // OK
add(a: 1, b: 2, c: 3)  // 明示的にラベルをつけてもよい
add(1, 2, 3)  // 引数cは_つけてないから、これはコンパイルエラー
```

## #

外部参照用のラベルと内部参照用のラベルが同じでいいときにつける...

```swift
func add(#a: Int8, #b: Int8) -> Int8 {
  return a + b;
}
```

...らしいのだがswift4だとコンパイルエラーである

```swift
  5> func add(#a: Int8, #b: Int8) -> Int8 {
  6.   return a + b;
  7. }
error: repl.swift:5:10: error: expected parameter name followed by ':'
func add(#a: Int8, #b: Int8) -> Int8 {
         ^

error: repl.swift:5:20: error: expected parameter name followed by ':'
func add(#a: Int8, #b: Int8) -> Int8 {
```

swift5のドキュメントには引数周りの `#` についてもう書いてないみたいだ

- [Functions — The Swift Programming Language (Swift 5)](https://docs.swift.org/swift-book/LanguageGuide/Functions.html)

## 所感

- `#selector` の記述が気になって調べたけど、そこはとくに納得できず
- 検索するときは `site:docs.swift.org` つけると公式から読める

## 参考

- [Expressions — The Swift Programming Language (Swift 5)](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID547)
- [Swiftのfuncの引数に出てくるアンダースコアやシャープの意味について調べた - Shoken Startup Blog](https://shoken.hatenablog.com/entry/2014/06/18/151548)


