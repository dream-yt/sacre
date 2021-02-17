---
title: "Formikで A component is changing an uncontrolled input of type text to be controlled"
slug: formik-uncontrolled-error
date: 2021-02-17T15:07:25+09:00
draft: false
author: sakamossan
---

Formik を使ったらこのエラーが出た。

> Warning: A component is changing an uncontrolled input to be controlled. This is likely caused by the value changing from undefined to a defined value, which should not happen. Decide between using a controlled or uncontrolled input element for the lifetime of the component. More info: https://reactjs.org/link/controlled-components

これは操作した `input#name` に `initialValue` に対応する属性がなかった場合に発生した。タイポ注意。

## 参考

- [react web - formik warning, A component is changing an uncontrolled input of type text to be controlled - Stack Overflow](https://stackoverflow.com/questions/61048254/formik-warning-a-component-is-changing-an-uncontrolled-input-of-type-text-to-be)
