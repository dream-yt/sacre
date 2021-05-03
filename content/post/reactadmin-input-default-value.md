---
title: "React-admin で Input にデフォルトの値を設定する"
slug: reactadmin-input-default-value
date: 2021-05-02T18:44:17+09:00
draft: false
author: sakamossan
---

ユーザが入力するテキストフィールドに、デフォルトの値を入れておきたい場合。
ちゃんとオプションが用意されていて、 `initialValues` に関数を渡せばできるようになっている。

- [React-admin - The Create and Edit Views](https://marmelab.com/react-admin/CreateEdit.html#default-values)

```tsx
const initialValues = () => ({ expireAt: new Date() });
export const UserCreate: React.FC<CreateProps> = props => (
  <Create {...props}>
      <SimpleForm redirect="list" initialValues={initialValues}>
          <DateInput source="expireAt" />
      </SimpleForm>
  </Create>
);
```

なお、フィールドごとに設定するオプションも各種コンポーネントに設定されているが、これは関数ではなく定数しか渡せないのでそんなに柔軟には設定できない。

> initialValue	Value to be set when the property is null or undefined

- [React-admin - Input Components](https://marmelab.com/react-admin/Inputs.html#common-input-props)
