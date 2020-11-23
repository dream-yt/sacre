---
title: "nextjsのSSGでhtmlでredirect"
date: 2020-11-20T18:50:25+09:00
draft: false
author: sakamossan
---

nextjsのSSGでブログを作っているが、技術系以外の記事もこのブログで管理したくなったので今ある技術系の記事を `/tech` 配下のパスにもってきたいということになった。

301でリダイレクトできればいいのだが、サーバはSSGで生成したhtmlをサーブしているだけだし、そこまでSEO的なページランクが惜しいわけでもないのでもう meta refresh でいいかなということにした。

## MetaRefreshRedirect

meta refresh をしてくれる react コンポーネント次のようになった。

```jsx
import React from "react";
import Head from "next/head";

export const MetaRefreshRedirect: React.FC<{ url: string }> = ({ url }) => (
  <Head>
    <link rel="canonical" href={url} />
    <meta httpEquiv="Refresh" content={`0; URL=${url}`}></meta>
  </Head>
);
```

### Head

nextjsではヘッダにタグを入れたいときは `Head` コンポーネントを使う。

- [next/head | Next.js](https://nextjs.org/docs/api-reference/next/head)

nextでは自動的に有象無象のjsファイルをhead内でロードしてくれるが、そこに触らないで済むためのコンポーネント。


### meta/httpEquiv="Refresh"

本当は301リダイレクトのほうがいいのだが、html内にこれを書くとブラウザが指示したページに遷移してくれる。

- [HTTP のリダイレクト - HTTP | MDN](https://developer.mozilla.org/ja/docs/Web/HTTP/Redirections#HTML_redirections)


### link rel="canonical"

本来はサイト内に違うURLで同じページがある場合に使うタグだが、つけておくとよいという記事を見つけたのでつけた。かなり古い記事なので実際は分からないが、「このページの本来のURLはここだよ!」という意味付けができるのは意図とあっている。

- [html - SEO consequences of redirecting with META REFRESH - Stack Overflow](https://stackoverflow.com/questions/5392001/seo-consequences-of-redirecting-with-meta-refresh)
- [Consolidate duplicate URLs  |  Help  |  Google Developers](https://developers.google.com/search/docs/advanced/crawling/consolidate-duplicate-urls?visit_id=637414406394929967-2935426438&rd=2)
