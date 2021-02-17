---
title: "Formikで A component is changing an uncontrolled input of type text to be controlled"
slug: formik-uncontrolled-error
date: 2021-02-17T14:59:42+09:00
draft: false
author: sakamossan
---

Formik を使いはじめたらこのエラーが出た。

> Warning: A component is changing an uncontrolled input to be controlled. This is likely caused by the value changing from undefined to a defined value, which should not happen. Decide between using a controlled or uncontrolled input element for the lifetime of the component. More info: https://reactjs.org/link/controlled-components


このエラーが出ないように Formik を使っているのだが、使い方が間違っていた。
initialValue には変数を入れないとダメだった。

## つまり

こうではなく

```jsx
  ReactDOM.render(
    <Formik initialValues={{}}>
        ...
```

こうする必要があった

```jsx
  const initialValue = {}
  ReactDOM.render(
    <Formik initialValues={initialValue}>
        ...
```

## 参考

> Need to create dynamic initialValues for formik as -

- [react web - formik warning, A component is changing an uncontrolled input of type text to be controlled - Stack Overflow](https://stackoverflow.com/questions/61048254/formik-warning-a-component-is-changing-an-uncontrolled-input-of-type-text-to-be)
