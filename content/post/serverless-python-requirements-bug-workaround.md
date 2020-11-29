---
title: "Serverless Python Requirements Bug Workaround"
date: 2020-11-28T10:09:28+09:00
draft: false
author: sakamossan
---

pythonのコードを serverless でデプロイしているときに以下のエラーが出た。

> TypeError: Cannot read property 'artifact' of undefined

serverless-python-requirements のバグのようだ。
issueになっていて、1年以上直っていない。

- [Unable to deploy single lambda function for version 1.52.1 · Issue #6752 · serverless/serverless](https://github.com/serverless/serverless/issues/6752)

とりあえずエラーにならないワークアラウンドとして以下の設定が言及されていた。

```yaml
functions:
  scrapeWorkStatus:
    package: {}  # これを追加
    handler: handler.scrapeWorkStatus
    ...
```

> I found a workaround but I'm not sure about the side effects.
> The problem is the following line (line # 176 in my version) in serverless-python-requirements/index.js file:

```yaml
hello:
    # ...
    package: {}
```
