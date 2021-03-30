---
title: "airflow の model.py を読んだ"
slug: airflow-reading-modelpy
date: 2021-03-23T15:27:52+09:00
draft: false
author: sakamossan
---

airflow の管理画面やドキュメントを理解しやすくするために自分用に用語とデータモデルについてメモした。

## 前提

airflowの設定や実行履歴を保存するメタデータベースはRDBSであり、SQLAlchemyから利用されている。
モデルには純粋なPythonのクラスとして定義されているものと、メタデータベースに入ってるデータをSQLAlchemyのORMとして扱ってるものの2種類がある。

今回読んだpythonコードは models.py

- [incubator-airflow/models.py at b87d3a49054f3890cf6714e7c4920973754b810e · databricks/incubator-airflow](https://github.com/databricks/incubator-airflow/blob/b87d3a49/airflow/models.py)

メタデータベースに入ってるデータはSELECTしたりすると見られるので、airflow自体の挙動でハマった時などはこの辺りのモデル定義をなんとなく知っていると調査がラクになるかもしれない。


## DagBag

- [incubator-airflow/models.py at b87d3a49054f3890cf6714e7c4920973754b810e · databricks/incubator-airflow](https://github.com/databricks/incubator-airflow/blob/b87d3a49/airflow/models.py#L144)

>  A dagbag is a collection of dags, parsed out of a folder tree and has high level configuration settings, like what database to use as a backend and what executor to use to fire off tasks.

- DagBagは普通のPythonクラスで./dagsからDAGの読み込み処理を担当する
- DAGの管理 (dag_idからDagインスタンスを引いたり)


## Connection

- [airflow/models.py#L510](https://github.com/apache/incubator-airflow/blob/master/airflow/models.py#L510)

> Placeholder to store information about different database instances connection information. The idea here is that scripts use references to database instances (conn_id) instead of hard coding hostname, logins and passwords when using operators or hooks.

- Connectionテーブルが定義されている
- 接続情報の管理をするレコード
- MySQLやS3などの外部リソース毎に接続情報をDBや環境変数で管理している
- 例えばMySQLなら `mysql://foo:bar@hostes.com/report?utf8=1` といった情報


## TaskInstance

- [incubator-airflow/models.py at b87d3a49054f3890cf6714e7c4920973754b810e · databricks/incubator-airflow](https://github.com/databricks/incubator-airflow/blob/b87d3a49/airflow/models.py#L732)

> Task instances store the state of a task instance. This table is the authority and single source of truth around what tasks have run and the state they are in.

- TaskInstanceテーブルが定義されている
- Taskとは、dags.pyで定義したDAGを実行したもの
  - DAGクラスののインスタンスといったイメージ
  - どのTaskがどういった状態かをこのテーブルで管理している
- おそらくユーザが一番興味を持つべきテーブル
  - どのタスクがどこまで成功したかなどの情報が入っている

カラム定義もジョブが失敗したときに知りたくなるような項目ばかり

```python
duration = Column(Float)
state = Column(String(20))
try_number = Column(Integer, default=0)
max_tries = Column(Integer)
...
hostname = Column(String(1000))
pid = Column(Integer)
```

モデルとは関係ないが `airflow run` するためのコマンドライン引数をパースしている処理はこのクラスに実装されていた。なにかハマったときに参考になるかもしれない。

- https://github.com/databricks/incubator-airflow/blob/b87d3a49/airflow/models.py#L872


## Log

- [incubator-airflow/models.py at b87d3a49054f3890cf6714e7c4920973754b810e · databricks/incubator-airflow](https://github.com/databricks/incubator-airflow/blob/b87d3a49/airflow/models.py#L1764)

> Used to actively log events to the database

- Logテーブルが定義されている
- dag(task)の実行履歴を入れるテーブル


## DagModel

- [incubator-airflow/models.py at b87d3a49054f3890cf6714e7c4920973754b810e · databricks/incubator-airflow](https://github.com/databricks/incubator-airflow/blob/b87d3a49/airflow/models.py#L2567)

> These items are stored in the database for state related information

- `dags/~.py` から読み込まれたDAG定義の情報はこのクラスから扱われる


## DAG

- [incubator-airflow/models.py at b87d3a49054f3890cf6714e7c4920973754b810e · databricks/incubator-airflow](https://github.com/databricks/incubator-airflow/blob/b87d3a49/airflow/models.py#L2613)

airflowの心臓部となるDAGクラスの定義

> A dag (directed acyclic graph) is a collection of tasks with directional dependencies. A dag also has a schedule, a start end an end date (optional). For each schedule, (say daily or hourly), the DAG needs to run each individual tasks as their dependencies are met. Certain tasks have the property of depending on their own past, meaning that they can't run until their previous schedule (and upstream tasks) are completed.

airflowではDAGクラスに諸々設定をしていくことでワークフローを書くことになる。

ワークフローを作るためのDAGクラスもこのファイルに定義されている。


## KnownEvent

- [incubator-airflow/models.py at b87d3a49054f3890cf6714e7c4920973754b810e · databricks/incubator-airflow](https://github.com/databricks/incubator-airflow/blob/b87d3a49/airflow/models.py#L3608)

ドキュメントなどでも見慣れない名前のテーブル。

- KnownEventType
- KnownEvent

ユーザが管理画面から設定する類のものなのかな 🤔


## XCom

- [incubator-airflow/models.py at b87d3a49054f3890cf6714e7c4920973754b810e · databricks/incubator-airflow](https://github.com/databricks/incubator-airflow/blob/b87d3a49/airflow/models.py#L3726)

XComとはdag間でメッセージングをするためのairflow独自の仕組み

- 文字列情報ならなんでも渡すことが出来る(JSONなどで構造化したデータも渡せる)
- XComはテーブルがある
    - `value`といったカラムが用意されていて、XComのメッセージはRDBSで管理されていることがわかる


## DagStat

- [incubator-airflow/models.py at b87d3a49054f3890cf6714e7c4920973754b810e · databricks/incubator-airflow](https://github.com/databricks/incubator-airflow/blob/b87d3a49/airflow/models.py#L3870)

こんなカラム定義のテーブル。

```python
dag_id = Column(String(ID_LEN), primary_key=True)
state = Column(String(50), primary_key=True)
count = Column(Integer, default=0)
dirty = Column(Boolean, default=False)
```

実行中のdagを監視するため後述のDagRunと一緒に使うテーブルに見える。


## DagRun

スケジューラがDagを実行したときに生成するレコードとのこと。

- [incubator-airflow/models.py at b87d3a49054f3890cf6714e7c4920973754b810e · databricks/incubator-airflow](https://github.com/databricks/incubator-airflow/blob/b87d3a49/airflow/models.py#L3987)

> DagRun describes an instance of a Dag. It can be created by the scheduler (for regular runs) or by an external trigger

管理画面から再実行する場合などはここのテーブルを参照して実行されるようだ。
