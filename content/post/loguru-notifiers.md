---
title: "loguruとnotifiersを使ってslack通知をする"
date: 2019-01-02T12:55:49+09:00
draft: false
author: sakamossan
---

## 前提

- slackはincomming webhookをdeprecateとしている
- notifiersはincomming webhookにしか対応していない
- 本来はloguruに渡すhandlerをSlackApp経由の実装にした方がよい


## それでもやる場合

かなり雑だが、以下のようなコードで通知まで出来る

```python
from notifiers.logging import NotificationHandler
from loguru import logger

SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/xxxxxxx'

handler = NotificationHandler(
    "slack", defaults={"webhook_url": SLACK_WEBHOOK_URL})
# level:warning以上でslack通知をする
logger.add(handler, level="WARNING")

def get_logger():
    return logger
```


## その他

`loguru.logger.catch` はデフォルトで例外を再送しない

```python
@logger.catch
def err(): 1/0

if __name__ == '__main__':
    err()
    # こちらも呼ばれる
    l = get_logger()
    l.info("test")
```

例外を再送したい場合は `reraise=True` をつける

```python
@logger.catch(reraise=True)
def err(): 1/0
```
