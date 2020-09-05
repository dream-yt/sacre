---
title: ReactでレンダリングしているページにGoogleAnalyticsを入れる"
date: 2020-09-05T12:03:51+09:00
draft: false
author: sakamossan
---

なんかいろんなプラグインがnpmにあったが、自分で `dangerouslySetInnerHTML` で直接書いてしまうのが楽だった

<pre>
import React from 'react';

export const GoogleAnalytics: React.FC = () => (
  <>
      <script src="https://www.googletagmanager.com/gtag/js?id=UA-123456789" />
      <script
        dangerouslySetInnerHTML={{
          __html: `
          window.dataLayer = window.dataLayer || [];
          function gtag(){dataLayer.push(arguments);}
          gtag('js', new Date());
          gtag('config', 'UA-123456789');
        `,
        }}
      />
  </>
);
<pre>