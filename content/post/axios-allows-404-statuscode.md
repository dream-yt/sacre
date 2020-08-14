---
title: "axiosでステータスコード404のときに例外をあげなくする"
date: 2019-11-17T12:54:35+09:00
draft: false
author: sakamossan
---

axiosはレスポンスのステータスが500でも404でも例外を投げてしまう

- [Don't throw error / catch on 400-level responses · Issue #41 · axios/axios](https://github.com/axios/axios/issues/41)

それで困る時、たとえば4xx系は許容したいときとかには  
`validateStatus`というオプションがある

デフォルトだと以下のようなチェックになっているようだ

- https://github.com/axios/axios/blob/1b07fb9365d38a1a8ce7427130bf9db8101daf09/lib/defaults.js#L78-L80

これを404は許容したいとカスタマイズする場合は以下のようにする

```ts
axios.create({
  validateStatus: status => (status >= 200 && status < 300) || status == 404
});
```
