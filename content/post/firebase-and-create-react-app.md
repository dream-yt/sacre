---
title: "create-react-app と firebase の環境構築"
slug: firebase-and-create-react-app
date: 2020-12-25T18:53:17+09:00
draft: false
author: sakamossan
--- 

公式で案内されている手順だと先にCRAをやることになる。

- [Deployment | Create React App](https://create-react-app.dev/docs/deployment/#firebase)

### CRA

```bash
$ npx create-react-app . --typescript --use-npm
```


### Firebaseのconsoleでいろいろ操作

先にいろいろつくらないと `firebase init` がコケる

- プロジェクトの作成
- リージョンの設定
- Functionsを使うならクレカを登録
- FireStoreを使うならデータベースを作成


### firebase init

- [Firebase CLI リファレンス](https://firebase.google.com/docs/cli?hl=ja#windows-npm)

```bash
$ firebase login
$ firebaee init
```


## その他

### `"public": "build"`

CRAがデフォルトでbuild配下に静的ファイルを吐き出すので、firebaseが参照する静的ファイルのディレクトリを`{public => build}`と変更

```diff
diff --git a/firebase.json b/firebase.json
index 66b75cd..a84a947 100644
--- a/firebase.json
+++ b/firebase.json
@@ -10,7 +10,7 @@
     ]
   },
   "hosting": {
-    "public": "",
+    "public": "build",
     "ignore": [
       "firebase.json",
       "**/.*",
```
### `root: true`

CRAのeslintの設定がfunctions配下のeslintの設定とぶつかるので、functions配下のeslintの設定に `root: true` を追加。eslintが親ディレクトリ(CRA側)の設定をみないように。

- [ESLint couldn't determine the plugin uniquely. · Issue #13385 · eslint/eslint](https://github.com/eslint/eslint/issues/13385#issuecomment-641252879)

```diff
diff --git a/functions/.eslintrc.js b/functions/.eslintrc.js
index 821e48b..9735185 100644
--- a/functions/.eslintrc.js
+++ b/functions/.eslintrc.js
@@ -14,10 +14,8 @@ module.exports = {
     project: "tsconfig.json",
     sourceType: "module",
   },
-  plugins: [
-    "@typescript-eslint",
-    "import",
-  ],
+  root: true,
+  plugins: ["@typescript-eslint", "import"],
```

あとは .gitignore

```diff
--- a/.gitignore
+++ b/.gitignore
@@ -23,3 +23,4 @@ yarn-debug.log*
 yarn-error.log*

 .eslintcach
+.firebase
```
