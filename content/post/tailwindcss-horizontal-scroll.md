---
title: "tailwindcss で横スクロール UI"
slug: tailwindcss-horizontal-scroll
date: 2020-12-20T15:12:18+09:00
draft: false
author: sakamossan
---

よくある横スクロールの UI を tailwind で実装する。

![](https://raw.githubusercontent.com/sakamossan/image-bed/master/assets/474e5647-92a5-9431-c9b5-dd4cc2dba247.png)

こんな感じで実現する。

```jsx
<ul className="flex overflow-x-auto">
  {list.map((g) => (
    <li className="flex-none w-2/5" key={g.id}>
      <Card imgSrc={g.imageUrl()} imgAlt={g.name}>
        <p>{g.name}</p>
      </Card>
    </li>
  ))}
</ul>
```

## 参考

- [css - Overflow-x not working - Stack Overflow](https://stackoverflow.com/questions/24132943/overflow-x-not-working#answer-24133053)
