---
title: "react-admin で、react-admin の機能を使わないページを作りたいときの方法"
slug: react-admin-custom-page-and-link
date: 2021-11-12T17:22:03+09:00
draft: false
author: sakamossan
---

react-admin で、完全にカスタマイズされたページを作りたいときの方法。

けっこういろいろ実装が必要になる方法しかなくて、マジかよとなるが、これは公式のドキュメントに書いてある方式で、GitHubのissueなどもこのやり方に沿ってやりとりされている。

## ルーティング

まず、ルーティングを定義する

- `customRoutes` を定義して、`Admin` タグの引数に渡す
- リクエストできるパスと、そのパスで表示されるコンポーネントを追加

```ts
import * as React from "react";
import { Route } from 'react-router-dom';
import {SampleQueryInput} from './Sample'

export default [
  <Route exact path="/sample" component={SampleQueryInput} />,
];
```

```diff
const App = () => (
-   <Admin dataProvider={dataProvider}>
+   <Admin customRoutes={customRoutes} dataProvider={dataProvider}>
```

## つくったルーティングへのリンク(Menu)

これだけだと、できたページへのリンクがないので、つぎに、そのルーティングへのリンクを、サイドバー( `Menu` と呼ばれる)に追加する。


```ts
import * as React from 'react';
import { useSelector } from 'react-redux';
import { Menu, MenuItemLink, getResources } from 'react-admin';
import DefaultIcon from '@material-ui/icons/ViewList';

export const CustomMenu = (props: any) => {
    const resources = useSelector(getResources);
    return (
        <Menu {...props}>
            {resources.map(resource => (
                <ItemLinkFromResource key={resource.name} resource={resource} />
            ))}
            <MenuItemLink
                key='sample'
                to="/sample"
                primaryText="sample"
                leftIcon={<DefaultIcon />}
            />
        </Menu>
    );
};

const ItemLinkFromResource = ({ resource }: any) => (
    <MenuItemLink
        to={`/${resource.name}`}
        primaryText={
            (resource.options && resource.options.label) ||
            resource.name
        }
        leftIcon={
            resource.icon ? <resource.icon /> : <DefaultIcon />
        }
    />
);
```

## つくった Menu を Admin コンポーネントに渡す

- できた CustomMenu コンポーネントを、
- CustomLayout コンポーネントに渡し、
- Layout コンポーネントを Admin に渡す。

```ts
import { Layout } from 'react-admin';
import { CustomMenu } from './Menu';

const CustomLayout = (props: any) => <Layout {...props} menu={CustomMenu} />;
export default CustomLayout;

```

```diff
- <Admin customRoutes={customRoutes} dataProvider={dataProvider}>
+ <Admin customRoutes={customRoutes} layout={layout} dataProvider={dataProvider}>
```


## 参考

- [menu | React-admin - Admin and Resource Components](https://marmelab.com/react-admin/Admin.html#menu)
- [customRoute | React-admin - Admin and Resource Components](https://marmelab.com/react-admin/Admin.html#customroutes)

