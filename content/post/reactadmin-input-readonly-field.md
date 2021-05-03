---
title: "React-admin の登録/更新画面でreadonlyなフィールドをつくる"
slug: reactadmin-input-readonly-field
date: 2021-05-02T18:52:59+09:00
draft: false
author: sakamossan
---

Listコンポーネントで使う `TextField` などのコンポーネントを使えばよい。

> A Field component displays a given property of a REST resource. Such components are used in the List and Show views, but you can also use them in the Edit and Create views for read-only fields.

- [React-admin - Field Components](https://marmelab.com/react-admin/Fields.html)

### 例

```tsx
  <Edit {...props}>
    <SimpleForm>
      // userId は readonly
      <TextField source="userId" />
      // expireAt は日付データのinput
      <DateInput source="expireAt" />
    </SimpleForm>
  </Edit>
```
