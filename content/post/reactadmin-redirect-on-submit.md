---
title: "React-admin で登録/更新時に一覧に遷移する"
slug: reactadmin-redirect-on-submit
date: 2021-05-02T14:59:04+09:00
draft: false
author: sakamossan
---

`SimpleForm` に `redirect` というpropsがあるのでそれを渡せばよい。
`list`, `show` といった引数の他に、URLを渡せるオプションもある。

```tsx
  <Edit {...props}>
      <SimpleForm redirect="list">
          <DateInput source="expireAt" />
      </SimpleForm>
  </Edit>
```

- [React-admin - The Create and Edit Views](https://marmelab.com/react-admin/CreateEdit.html#redirection-after-submission)
