---
title: "swiftのselectorについて"
date: 2019-03-16T12:19:07+09:00
draft: false
author: sakamossan
---

- コールバックを渡すための仕組みのようなもの?
- たとえばメソッドを渡してイベントが発生した時の実行するような場合につかう?

```swift
var button = UIButton()
button.addTarget(self, action: "tappedButton:", forControlEvents: .TouchUpInside)
```

> 今度はSwiftの例ですが、上記のコードではボタンが押されたらselfに定義してあるtappedButtonというメソッドが実行されます。

swiftの以前のバージョンだと↑のように文字列を渡していたが、
最近ではメソッドを `#selector` インスタンスを生成して引数に渡すようなっている

```swift
var button = UIButton()
button.addTarget(self, action: #selector(MyClass.myMethod(_:)), forControlEvents: .TouchUpInside)
```

こんな感じなのかな? (動かしていない)


## 参考

- [iOS - Swift（またはObjective-C）のselectorについて｜teratail](https://teratail.com/questions/10558)
- [今から始める Swift 3 対策 - A Day In The Life](http://glassonion.hatenablog.com/entry/2016/06/07/214819)
