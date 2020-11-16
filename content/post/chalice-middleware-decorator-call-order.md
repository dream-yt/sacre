---
title: "chalice.Middleware の呼ばれる順番について"
date: 2020-11-16T17:39:08+09:00
draft: false
author: sakamossan
---

chaliceにはMiddlewareと呼ばれる仕組みがある

- [Middleware — AWS Chalice](https://aws.github.io/chalice/topics/middleware.html)


これを使うと、すべての関数に処理を挟み込むことができる。たとえば認証をしてダメだったら400を返したり、パラメータをログ出力したり。

### 例

```python
@app.middleware('http')
def require_header(event, get_response):
    if 'X-Custom-Header' not in event.headers:
        return Response(status_code=400)
    else:
        print("here!")
        return get_response(event)
```

そういった処理はこれまではデコレータを使って実現していたが、両方使った場合に処理が呼ばれる順番はどうなるのか確認してみた。

ついでに2つMiddlewareを宣言した時にそれらもどういう順番になるかもみてみた。


## 実験用のコード

Middlwwareを2つ宣言して、Decoratorも使った

```python
@app.middleware('http')
def middleware1(event, get_response):
    print('middleware1')
    return get_response(event)

@app.middleware('http')
def middleware1(event, get_response):
    print('middleware2')
    return get_response(event)
    
def decorator(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        print("decorator")
        return func(*args, **kwargs)
    return wrapper

@app.route('/')
@decorator
def index():
    return {'hello': 'world'}
```

## 結果

ログが出る順番はこうなった

```
middleware1
middleware2
decorator
```


## つまり

- MiddlewareはDecoratorよりも先に呼ばれる
    - 外側にデコレートされるとも言える
- Middlewareは宣言した順番に呼ばれる
    - `@app.middleware` した順番
