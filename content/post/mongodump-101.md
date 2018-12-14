---
title: "mongodump/mongoexportのやりかた"
date: 2018-12-14T13:11:58+09:00
draft: false
---

mongoexport ってのでjson形式で吐き出せる (jqを使って作業がしやすい)

```bash
mongoexport \
    --host=aws-singapore-free-shard-00-01-xxxx.mongodb.net \
    --port=27017 \
    --username=app \
    --authenticationDatabase=admin \
    --password=xxxxxx \
    --ssl \
    --db=abcd \
    --collection=profiles \
    --out /tmp/profiles.json
```
