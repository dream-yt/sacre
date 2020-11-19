---
title: "pythonのbdistとsdistとwheelファイルについて"
date: 2020-11-19T20:38:40+09:00
draft: false
author: sakamossan
---

lambdaで動くpythonのアプリケーションを開発するとき、依存モジュールをrequirements.txtの記述でなく生のwheelファイルで管理したいという要望があった。そもそもそれがどういう要望かわかってないくらいwheelファイルについてわかってなかったので、wheelファイルとそのつくりかたを調べた。


## wheel とは

python標準のソフトウェアパッケージ方式。PEP427で定義されている。
ソフトウェアをpypiに公開するときなどにお世話になる。

wheelの他にはeggというパッケージ形式もある (eggのほうが古い形式)。

- [Wheel vs Egg — Python Packaging User Guide](https://packaging.python.org/discussions/wheel-vs-egg/)

なお、wheelは通常の文脈だとライブラリをパッケージする形式のことになるが、wheelというコマンドラインツールも存在するので文脈によっては注意。


#### .whl

.whlファイルはwheel形式でパッケージされたファイルの拡張子。ファイル名の中にlinux向けx86向けcpythonなどなど、ビルドターゲットのプラットフォームの情報が書いてある。

##### 例

```
wrapt-1.12.1-cp38-cp38-macosx_10_15_x86_64.whl
```

## bdistとsdist

pythonのパッケージの配布形式は2つある。

- bdist: ビルド済みのファイルを配布すること (whl)
- sdist: ソースコードを配布すること (tar.gz)

cエクステンションなどをつかっているライブラリはいろんな形式に対応するのが難しくてsdistになりがちなようだ。

#### 難しそうな例

- [Distribute also in Wheel · Issue #39 · GrahamDumpleton/wrapt](https://github.com/GrahamDumpleton/wrapt/issues/39#issuecomment-83987473)

> Doing Windows could be a pain as don't use Windows normally and rarely crank up the Windows VM. Not sure whether I am set up to create wheels on Windows and creating wheels for multiple Python versions as well as 32 bit and 64 bit variants would be a lot of effort.

#### setup.py の引数

これらはパッケージングするときにどちらを引数でわたすかで違う。

```bash
python setup.py sdist
python setup.py bdist_wheel
```


## pip download

`pip download` を実行するとbdist(wheelファイル)か、sdist(ソースコードのtar.gzファイル)が落ちてくる。このコマンドは依存するパッケージもダウンロードする。

```bash
$ pip download aws_lambda_powertools
# whlファイルが落ちてくる
$ ls -1 | head -3
aws_lambda_powertools-1.7.0-py3-none-any.whl
aws_xray_sdk-2.6.0-py2.py3-none-any.whl
boto3-1.16.21-py2.py3-none-any.whl
# モジュール側がsdist形式で配布している場合はtar.gzが落ちてくる
$ ls -1 | grep future
future-0.18.2.tar.gz
```

なお、以下のURLで目当てのモジュールがbdistかsdistかどちらで配布をしているかがわかる

- `https://pypi.org/pypi/{{ module name }}/json` 

なお、tar.gz を解凍して中身を setup.py bdist_wheel するとモジュールによってはそれでwheelファイルを作ってくれる。(先述のwraptとかはそれでは作れなかった)

```bash
$ tar zxvf {{ module name }}.tar.gz
$ cd {{ module name }}
$ python setup.py bdist_wheel
```

## pip wheel

今回はwheel形式で依存を管理したいという話だったのでこのコマンドを使った。

これは pip download に近いが、sdist形式で配布しているモジュールの場合はビルドしてwheel形式にしておいてくれる。

```bash
$ pip wheel aws-lambda-powertools
...
# ビルドしてくれる
Building wheels for collected packages: future, wrapt
  Building wheel for future (setup.py) ... done
  Created wheel for future: filename=future-0.18.2-py3-none-any.whl size=491059 sha256=82de079d7fbe55933a2b22cf0ec3a3066dd8b7cf5add962a1f8123ce2ad83f12
  Stored in directory: /private/tmp/docker-lambda
...
# wheelファイルが配置される
$ ls -1 | grep future
future-0.18.2-py3-none-any.whl
```

## 参考

- [Python パッケージングの標準を知ろう - Tech Blog - Recruit Lifestyle Engineer](https://engineer.recruit-lifestyle.co.jp/techblog/2019-12-25-python-packaging-specs/)
- [pip wheel — pip 20.2.4 documentation](https://pip.pypa.io/en/stable/reference/pip_wheel/)
