---
title: "React-admin のチュートリアルを読んだメモ"
slug: react-admin-tutorial
date: 2021-03-31T18:12:23+09:00
draft: false
author: sakamossan
---

読んだのでメモ

- [React-admin - My First Project Tutorial](https://marmelab.com/react-admin/Tutorial.html)

# 一覧画面

React-admin では一覧表は管理画面によくあるテーブル形式で表示する。

![](https://raw.githubusercontent.com/sakamossan/image-bed/master/assets/9fb449a8-451f-4c30-a3d3-84bccf7785cb.png)

## dataProvider

```js
// in src/App.js
import * as React from "react";
import { Admin } from 'react-admin';
import jsonServerProvider from 'ra-data-json-server';

const dataProvider = jsonServerProvider('https://jsonplaceholder.typicode.com');
const App = () => <Admin dataProvider={dataProvider} />;

export default App;
```

Adminコンポーネントの引数で、サーバサイドのWebAPIがどんな仕様かを定義するもの。

>  a function capable of fetching data from an API. Since there is no standard for data exchanges between computers, you will probably have to write a custom provider to connect react-admin to your own APIs

ReactAdminは基本的にはAPIにはRESTを期待していて、デフォルトで用意されているdataProviderはRESTのAPIをやりとりするためのモジュールとなっている。


## Resource

Adminコンポーネントの子要素にResourceコンポーネントを定義することで、リソースの管理画面が生成される。

```diff
import { Admin, Resource, ListGuesser } from 'react-admin';

-const App = () => <Admin dataProvider={dataProvider} />;
+const App = () => (
+    <Admin dataProvider={dataProvider}>
+        <Resource name="users" list={ListGuesser} />
+    </Admin>
+);
```

> The line <Resource name="users" /> informs react-admin to fetch the “users” records from the https://jsonplaceholder.typicode.com/users URL. <Resource> also defines the React components to use for each CRUD operation (list, create, edit, and show).

`name="users"` というのはdataProviderに渡したURLのパスを参照してくれる。

### ListGuesser

> The list={ListGuesser} prop means that react-admin should use the <ListGuesser> component to display the list of posts. This component guesses the format to use for the columns of the list based on the data fetched from the API.

ListGuesser とは、名前の通り値からカラムの型を推定していい感じにリスト表示してくれるもの。

![](https://raw.githubusercontent.com/sakamossan/image-bed/master/assets/4320a6d2-88e6-cf0c-3217-68cabd851ef1.png)

ListGuesser はそのままプロダクションで使うものではない。が、かなり気が利いていて、自分がいまどんな定義のコンポーネントを吐き出しているかのソースコードをブラウザのコンソールログに出してくれる。ユーザはいまの見た目で満足していればでているログをコピペすれば実装が済むようになっている。

![](https://raw.githubusercontent.com/sakamossan/image-bed/master/assets/bd629101-9ee3-2f06-c119-61d059190f84.png)


## カスタムフィールド

リスト表示で呼ばれるコンポーネントはカスタムのフィールドが簡単に作れるようになっている。

```js
import * as React from "react";

// recordは行のデータで、sourceが表示しようとしているカラム名
const MyUrlField = ({ record = {}, source }) =>
    <a href={record[source]}>
        {record[source]}
    </a>;

export default MyUrlField;
```


## Relationships

関連するデータを使って表示をリッチにすることができる。
チュートリアルであげられている例は投稿(post)を一覧する画面で、post.userId をもとに user.name を表示するものだった。

```jsx
// in src/posts.js
import * as React from "react";
import { List, Datagrid, TextField, ReferenceField } from 'react-admin';

export const PostList = props => (
    <List {...props}>
        <Datagrid rowClick="edit">
            <ReferenceField source="userId" reference="users">
                <TextField source="name" />
            </ReferenceField>
            <TextField source="id" />
            <TextField source="title" />
            <TextField source="body" />
        </Datagrid>
    </List>
);
```

N+1回でAPIを叩かないような最適化が施されているそうだ

> Look at the network tab of your browser again: react-admin deduplicates requests for users, and aggregates them in order to make only one HTTP request to the /users endpoint for the whole Datagrid. That’s one of many optimizations that keep the UI fast and responsive.


# 更新画面

![](https://raw.githubusercontent.com/sakamossan/image-bed/master/assets/00721a43-c6e0-76e0-d7f5-dd8c0e6a1f24.png)

リソースの更新画面もGuesserを使ってまず簡単に作り始めることができる。

```diff
// in src/App.js
-import { Admin, Resource } from 'react-admin';
+import { Admin, Resource, EditGuesser } from 'react-admin';
import { PostList } from './posts';
import { UserList } from './users';

const App = () => (
    <Admin dataProvider={dataProvider}>
-       <Resource name="posts" list={PostList} />
+       <Resource name="posts" list={PostList} edit={EditGuesser} />
        <Resource name="users" list={UserList} />
    </Admin>
);
```

更新画面のコンポーネント実装はこんな感じになる。
(これもGuesserがconsoleにコードを吐いてくれるのでコピペするだけで済む)

```js
export const PostEdit = props => (
    <Edit {...props}>
        <SimpleForm>
            <ReferenceInput source="userId" reference="users">
                <SelectInput optionText="id" />
            </ReferenceInput>
            <TextInput source="id" />
            <TextInput source="title" />
            <TextInput source="body" />
        </SimpleForm>
    </Edit>
);
```

編集画面だけでなく、新規作成画面の実装はこんな感じ。

```diff
const App = () => (
-       <Resource name="posts" list={PostList} edit={EditGuesser} />
+       <Resource name="posts" list={PostList} edit={PostEdit} create={PostCreate} />
);
```

```js
export const PostCreate = props => (
    <Create {...props}>
        <SimpleForm>
            <ReferenceInput source="userId" reference="users">
                <SelectInput optionText="name" />
            </ReferenceInput>
            <TextInput source="title" />
            <TextInput multiline source="body" />
        </SimpleForm>
    </Create>
);
```

## 一覧画面のフィルタ

管理画面によくある機能として一覧からフィルタする機能が追加できる。

![](https://raw.githubusercontent.com/sakamossan/image-bed/master/assets/523e7daa-8bc1-2b4b-b1ac-2ba67dde389c.png)

実装側は投稿の名前などからフィルタする意外にも、ユーザをselectboxから選んでフィルタできるようになっている。

```jsx
// in src/posts.js
import { Filter, ReferenceInput, SelectInput, TextInput, List } from 'react-admin';

const PostFilter = (props) => (
    <Filter {...props}>
        <TextInput label="Search" source="q" alwaysOn />
        <ReferenceInput label="User" source="userId" reference="users" allowEmpty>
            <SelectInput optionText="name" />
        </ReferenceInput>
    </Filter>
);

export const PostList = (props) => (
    <List filters={<PostFilter />} {...props}>
        // ...
    </List>
);
```


# 認証

`authProvider` を実装して `Admin` コンポーネントの引数に渡すことで認証されているときのみ一覧を表示するという挙動にすることができる。

```js
import authProvider from './authProvider';

const App = () => (
    <Admin dashboard={Dashboard} authProvider={authProvider} dataProvider={dataProvider}>
        // ...
    </Admin>
);
```
