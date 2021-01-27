---
title: "[gcloud] module 'importlib' has no attribute 'util'"
slug: gcloud-python39-import-lib-error
date: 2021-01-27T12:06:06+09:00
draft: false
author: sakamossan
---

gcloudでこんなエラーがでる

```
$ gcloud components update
Traceback (most recent call last):
  File "/Users/mossan/google-cloud-sdk/lib/gcloud.py", line 104, in <module>
    main()
  File "/Users/mossan/google-cloud-sdk/lib/gcloud.py", line 62, in main
    from googlecloudsdk.core.util import encoding
  File "/Users/mossan/google-cloud-sdk/lib/googlecloudsdk/__init__.py", line 23, in <module>
    from googlecloudsdk.core.util import importing
  File "/Users/mossan/google-cloud-sdk/lib/googlecloudsdk/core/util/importing.py", line 23, in <module>
    import imp
  File "/usr/local/Cellar/python@3.9/3.9.1/Frameworks/Python.framework/Versions/3.9/lib/python3.9/imp.py", line 23, in <module>
    from importlib import util
  File "/usr/local/Cellar/python@3.9/3.9.1/Frameworks/Python.framework/Versions/3.9/lib/python3.9/importlib/util.py", line 2, in <module>
    from . import abc
  File "/usr/local/Cellar/python@3.9/3.9.1/Frameworks/Python.framework/Versions/3.9/lib/python3.9/importlib/abc.py", line 17, in <module>
    from typing import Protocol, runtime_checkable
  File "/usr/local/Cellar/python@3.9/3.9.1/Frameworks/Python.framework/Versions/3.9/lib/python3.9/typing.py", line 26, in <module>
    import re as stdlib_re  # Avoid confusion with the re we export.
  File "/usr/local/Cellar/python@3.9/3.9.1/Frameworks/Python.framework/Versions/3.9/lib/python3.9/re.py", line 124, in <module>
    import enum
  File "/Users/mossan/google-cloud-sdk/lib/third_party/enum/__init__.py", line 26, in <module>
    spec = importlib.util.find_spec('enum')
AttributeError: module 'importlib' has no attribute 'util'
```

サポートフォーラムによるとPython3.9の破壊的変更でgcloudコマンドが動かなくなってるとのこと

> To enable gcloud to work with Python 2.7.x as well as Python 3+ a shim was introduced to enable the enum module years ago. This shim breaks with Python 3.9 because of this commit https://github.com/python/cpython/commit/7f7e706d78ab968a1221c6179dfdba714860bd12, it looks like the root cause has already been removed in commit https://github.com/python/cpython/commit/9e09849d20987c131b28bcdd252e53440d4cd1b3 which looks to be scheduled to be released in Python 3.10.

- [Add support for python 3.9 [170125513] - Visible to Public - Issue Tracker](https://issuetracker.google.com/issues/170125513)


## 解決方法

いまはgcloudをアップグレードすればなおる。

gcloudをアップグレードするためのgcloudコマンドを動かすために `CLOUDSDK_PYTHON=python2` をつけて古いpythonを使って実行できるようにする。

```
$ CLOUDSDK_PYTHON=python2 gcloud components update
```
