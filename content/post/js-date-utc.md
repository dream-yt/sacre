---
title: "jsでローカルのタイムゾーンに関係なく、日付っぽい文字列をUTCで評価したい"
date: 2019-03-03T19:13:14+09:00
draft: false
author: sakamossan
---

jsのDateオブジェクトはデフォルトで色々な日付っぽい文字列を受け取るが、受け取った日付っぽい文字列をローカルのタイムゾーンとして評価してしまう

```console
$ # jsのDateオブジェクトは普通にconsole.logするとUTCでの時刻を出力する
$ node -p 'new Date("2019-03-03T11:00:00")'
2019-03-03T02:00:00.000Z
$ # toStringするとどのタイムゾーンとして評価しているかが見られる
$ node -p 'new Date("2019-03-03T11:00:00").toString()'
Sun Mar 03 2019 11:00:00 GMT+0900 (JST)
$ TZ=UTC node -p 'new Date("2019-03-03T11:00:00")'
2019-03-03T11:00:00.000Z
$ TZ=America/Los_Angeles node -p 'new Date("2019-03-03T11:00:00")'
2019-03-03T19:00:00.000Z
```

渡された日付っぽい文字列が常にUTCだとわかっている場合はローカルのタイムゾーンではなくUTCとして評価して欲しい。この場合は日付っぽい文字列に細工をしてUTCとして評価してもらうことができる

jsのDateオブジェクトが受け取る日付っぽい文字列はISO8601の規格に対応しているので、タイムゾーン指定子を日付っぽい文字列につければ、ローカルのタイムゾーンに関係なく評価してもらえる

UTCのタイムゾーン指定子は `Z` なので、これをつければUTCとして評価される

```console
$ node -p 'new Date("2019-03-03T11:00:00" + "Z")'
2019-03-03T11:00:00.000Z
$ # '2019-03-03T11:00:00' がUTCとして評価されて、JSTに変換されている
$ node -p 'new Date("2019-03-03T11:00:00" + "Z").toString()'
Sun Mar 03 2019 20:00:00 GMT+0900 (JST)
$ TZ=UTC node -p 'new Date("2019-03-03T11:00:00" + "Z")'
2019-03-03T11:00:00.000Z
$ TZ=UTC node -p 'new Date("2019-03-03T11:00:00" + "Z").toString()'
Sun Mar 03 2019 11:00:00 GMT+0000 (UTC)
$ TZ=America/Los_Angeles node -p 'new Date("2019-03-03T11:00:00" + "Z")'
2019-03-03T11:00:00.000Z
```

### 参考

- [ISO 8601 / タイムゾーン指定子 - Wikipedia](https://ja.wikipedia.org/wiki/ISO_8601#%E6%97%A5%E4%BB%98%E3%81%A8%E6%99%82%E5%88%BB%E3%81%AE%E7%B5%84%E5%90%88%E3%81%9B)
- [Specify a time zone for format()? · Issue #489 · date-fns/date-fns](https://github.com/date-fns/date-fns/issues/489)


### 参考

- [ISO 8601 / タイムゾーン指定子 - Wikipedia](https://ja.wikipedia.org/wiki/ISO_8601#%E6%97%A5%E4%BB%98%E3%81%A8%E6%99%82%E5%88%BB%E3%81%AE%E7%B5%84%E5%90%88%E3%81%9B)
- [Specify a time zone for format()? · Issue #489 · date-fns/date-fns](https://github.com/date-fns/date-fns/issues/489)
