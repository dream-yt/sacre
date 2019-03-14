---
title: "React.cloneElementとは"
date: 2019-03-14T15:03:40+09:00
draft: false
---

- 子要素にpropsを渡すための仕組み
- Reactではmutableを嫌うため、VDOMをimmutableに扱うための仕組み
- 既存の子要素そのままではなく、propsが渡されたコピーを生成する

### ドキュメント

> The resulting element will have the original element’s props with the new props merged in shallowly.
> New children will replace existing children

- [React Top-Level API – React](https://reactjs.org/docs/react-api.html#cloneelement)
