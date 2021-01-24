---
title: "tailwindでハンバーガーメニューをつくる"
slug: humbergermenu-100
date: 2021-01-22T23:21:23+09:00
draft: false
author: sakamossan
---

途中までやったところのメモ

- [初めてでもわかるTailwindcss入門(2)ナビゲーションバー | アールエフェクト](https://reffect.co.jp/html/tailwind-for-beginners-navigation-menu)

```jsx
const Nav = () => (
  <header className="container mx-auto text-black">
    <nav className="flex justify-between items-center">
      <div className="p-3">
        <Link href="/">
          <img src="/image/logo.png" width="250" height="30" />
        </Link>
      </div>
      <div>
        <button className="md:hidden">
          <svg className="h-6 w-6 fill-current" viewBox="0 0 24 24">
            <path d="M24 6h-24v-4h24v4zm0 4h-24v4h24v-4zm0 8h-24v4h24v-4z" />
          </svg>
        </button>
      </div>
    </nav>
    <div>
      <ul className="md:flex md:justify-end">
        <MenuItem url="/foo">FOO</MenuItem>
        <MenuItem url="/bar">BAR</MenuItem>
        <MenuItem url="/baz">BAZ</MenuItem>
      </ul>
    </div>
  </header>
)
const MenuItem = ({ url, children, isLast }) => (
  <li className={isLast ? "" : "border-b"}>
    <span className="block px-8 py-2 my-2 hover:bg-gray-100 rounded md:px-2 md:text-xs">
      <Link href={url}>{children}</Link>
    </span>
  </li>
);
```

### nav. items-center

> items-center(align-items:center;)で揃えることができます。

`items-center` はフォントの高さを揃えるために入っている


### nav. flex justify-between

`flex justify-between` によって、`nav` タグの中身が縦でなく横に並ぶようになる。
`justify-between` は端から端の範囲で要素が等間隔で並ぶ指定。

> Use justify-between to justify items along the container's main axis such that there is an equal amount of space between each item:

- [Justify Content - Tailwind CSS](https://tailwindcss.com/docs/justify-content#space-between)


### li. hover:bg-gray-100 rounded

- リンクがホバーで色がつくように
- どうせなら角丸で色がつくように


### li. border-b

- 区切り線のために下線をひく
- margin/paddingの外につけたいのでspanでなくliに

### ul. md:flex md:justify-end

- iPad以上の大きさの画面(PC画面)でリンクアイテムを横並びに
- リンクアイテムは右に寄せたいのでjustify-end

### button. md:hidden

ハンバーガーを非表示に。

### span. md:px-2 md:text-sm

リンクアイテムの余白と文字サイズを調整

# 残りTODO

- PC画面のときだけリンクアイテムをロゴと同じ高さにしたい
- ハンバーガーメニューの開閉
