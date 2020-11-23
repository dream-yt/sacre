---
title: "redux-form (handleSubmit) 入門"
slug: redux-form-101-handleSubmit
date: 2019-06-16T10:23:17+09:00
draft: false
author: sakamossan
---


# redux-form (handleSubmit) 入門

## MyFormコンポーネントを定義

自前で実装するフォーム

```jsx
const MyForm = ({ handleSubmit }) => (
  <form onSubmit={handleSubmit}>
    <div>
      <label htmlFor="firstName">First Name</label>
      <Field component={renderTextField} name="firstName" type="text" />
    </div>
    <button type="submit">Submit</button>
  </form>
);
```

> ({ handleSubmit }) => (

- reduxFormからhandleSubmitというpropsが渡される
  - formがsubmitされたときに実行されるべき関数 (後述)

> component={renderTextField}

自前のカスタムコンポーネントを渡すことができる
`component="input"` などと文字列で渡すと普通のデフォルトのinput要素で描画される

## reduxForm

- reduxFormでMyFormをデコレートする
  - これをすることでredux-formの便利関数がMyFormにpropsとして使えるように
  - handleSubmitもこれ経由でpropsに渡ってきている
- `sampleIt` はredux-form内でこのフォームを管理するときの名前
  - 複数フォームにまたがった処理を書くときとかに使うのだろうか

```ts
const RDForm = reduxForm({ form: 'sampleIt' })(MyForm);
```


## 使うところ

onSubmit属性に好きな関数を渡して使う
(多くの場合はサーバ側にPOSTしたりとか)

```jsx
<RDForm onSubmit={console.log} />
```

ここの `RDForm#onSubmit` propsとして渡した関数は
`MyForm#handleSubmit` propsとして渡ってくることになる

例だと単純に `組み込みform#onSubmit` に渡している


## 参考

- [Redux Form入門 - Qiita](https://qiita.com/yhosok/items/ab8e990403749690d846)
