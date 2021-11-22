---
title: "react-admin ですこし複雑なデータをPOSTしたい場合"
slug: react-admin-post-complex-jsondata
date: 2021-11-22T17:03:49+09:00
draft: false
author: sakamossan
---

たとえば、こんな感じのネストした要素があるJSONをPOSTしたい場合。

```json
{
    "id": 123,
    "name": {
        "first": "yoshida",
        "last": "shigeru"
    }
}
```

こんな感じで、ドット区切りでsourceを定義すればよい。

```jsx
<SimpleForm>
    <TextInput source="id"/>
    <TextInput source="name.first"/>
    <TextInput source="name.last"/>
</SimpleForm>
```


## もっと複雑なデータ構造をPOSTしたい場合

`transform` 属性を使う。

- [React-admin - The Create and Edit Views](https://marmelab.com/react-admin/CreateEdit.html#transform)

FormData を引数とする関数を定義できて、これがPOST直前に呼ばれるようにできる。
この関数はPromiseを返すこともできるとのこと。

```tsx
export const UserCreate = (props) => {
    const transform = data => ({
        ...data,
        fullName: `${data.firstName} ${data.lastName}`
    });
    return (
        <Create {...props} transform={transform}>
            ...
        </Create>
    );
}
```
