---
title: "htmlではaタグはネストできない"
date: 2020-05-19T08:12:33+09:00
draft: false
author: sakamossan
---

htmlではaタグがネストできない。できないと言うか、そういうコードを書くとブラウザがDOM構造をネストのない形に勝手に変更する。警告はでない。


## たとえば

aタグの中にaタグが入ってる形

```html
<a>
    <p>テストテスト</p>
    <a>リンク</a>
</a>
```

↑のコードを書くと、ブラウザはこれを↓のようにDOMツリーにする

```html
<a>
    <p>テストテスト</p>
</a>
<a>リンク</a>
```


## 理由

こんな理由でaタグのネストはできないことになっている

- もともとaタグはリンクできるタグであり、aタグ=リンク ではない
- aタグは概念上、点であり面積をもたない (よって他の要素を含まない)
- aタグは他のページとの接続点を示すタグである
- aタグが他のaタグを含むと、定義上どちらへの接続なのかが曖昧になる


#### 参考

- [html - Why are nested anchor tags illegal? - Stack Overflow](https://stackoverflow.com/questions/18666915/why-are-nested-anchor-tags-illegal)


## 対処法

objectタグでaタグを囲うと、書いた通りのDOMツリーになる
が、これは明らかなハックなのでやらないで済むならしないほうがよい

```html
<a>
    <p>テストテスト</p>
    <object>
        <a>リンク</a>
    </object>
</a>
```


#### 参考

- [aタグの中にaタグを書きたい時のtips - Qiita](https://qiita.com/fukamiiiiinmin/items/7412b21c6df5de31cab1#2a%E3%82%BF%E3%82%B0%E5%86%85%E3%81%AEa%E3%82%BF%E3%82%B0%E3%81%AFobject%E3%82%BF%E3%82%B0%E3%81%A7%E5%9B%B2%E3%82%80)
