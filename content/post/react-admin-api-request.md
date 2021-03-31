---
title: "React-admin のAPIリクエストと認証について"
slug: react-admin-api-request
date: 2021-03-31T18:14:26+09:00
draft: false
author: sakamossan
---

こちらの続き

- [React-admin のチュートリアルを読んだメモ](https://blog.n-t.jp/tech/react-admin-tutorial/)

管理画面の表示を認証認可で切り盛りするのはチュートリアルに書いてあったが、APIにリクエストするときのクレデンシャルの渡し方が説明されていなかったのでそれについて調べた。

ドキュメントにはちゃんと記載があって `simpleRestProvider` のコンストラクタの引数に httpClient を渡すことができる。
これにヘッダをいじる処理を実装して使うことでローカルで持っているクレデンシャルをAPIにヘッダとして送ることができるようになる。

- [react-admin/Authentication.md at master · marmelab/react-admin](https://github.com/marmelab/react-admin/blob/master/docs/Authentication.md#sending-credentials-to-the-api)

```js
import { fetchUtils, Admin, Resource } from 'react-admin';
import simpleRestProvider from 'ra-data-simple-rest';

const httpClient = (url, options = {}) => {
    if (!options.headers) {
        options.headers = new Headers({ Accept: 'application/json' });
    }
    const { token } = JSON.parse(localStorage.getItem('auth'));
    options.headers.set('Authorization', `Bearer ${token}`);
    return fetchUtils.fetchJson(url, options);
};
const dataProvider = simpleRestProvider('http://localhost:3000', httpClient);

const App = () => (
    <Admin dataProvider={dataProvider} authProvider={authProvider}>
        ...
    </Admin>
);
```

なお、`simpleRestProvider` の実装はこのようになっている。サーバ側を実装する際にはここの処理を参照して、極力このプロバイダを使い倒せるようなAPIとして実装すればクライアントの実装をかなり楽にすることができるはず。

- [react-admin/index.ts at master · marmelab/react-admin](https://github.com/marmelab/react-admin/blob/master/packages/ra-data-simple-rest/src/index.ts)
