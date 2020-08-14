---
title: "lodashのchain/wrapperオブジェクトをjsxで使う"
date: 2019-03-03T12:16:26+09:00
draft: false
author: sakamossan
---

lodashのchainに配列を渡すとlodashWrapperオブジェクトが得られる。これはlodashの便利メソッドを色々持っているArrayみたいな機能を持っている

### 使い方

こんな按配で縦に処理が並べられるのは若干見やすいような気がする。lodashWrapperのことを知らなくても何をしてるかはなんとなく想像つくし

```js
import _ from 'lodash';  // `chain` メソッドでも同じことができるようだ

const _List = _(list)
  .map(x => ({ id: x.id }))
  .uniqBy(({ id }) => id)
  .sortBy(({ id }) => id)
```

### ceveat

jsxはlodashWrapperをハンドリング出来ないのでArrayにしてやる必要がある
たとえばjsxでタグのリストを返すようなのに使う場合、こんな感じで最後に`value()`をつけてjs組み込みのArrayにしてやらないと展開されない

```jsx
const _List = _(list)
  .map(x => ({ id: x.id }))
  .uniqBy(({ id }) => id)
  .sortBy(({ id }) => id)
  .value()

return (
    <Select value="1">
      // value() しないと _List.map がArrayでなくlodashWrapperを返してしまう
      {_List.map(({ id }) => <MenuItem value={id} />)}
    </Select>
)
```

### 参考

- [Lodash Documentation](https://lodash.com/docs/2.4.2#lodash)
