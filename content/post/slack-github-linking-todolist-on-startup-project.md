---
title: "SlackとGitHub連携TODOリスト(新規プロジェクト作成時)"
slug: slack-github-linking-todolist-on-startup-project
date: 2022-01-04T11:23:29+09:00
draft: false
author: sakamossan
---

毎回ググったりしているのでリスト化。

## GitHub 

- [ ] リポジトリを作成
- [ ] GitHub内の Slack アプリに、つくったリポジトリへのアクセスを許可
  - [Installed GitHub Apps](https://github.com/settings/installations)

## Slack

- [ ] Slackのワークスペースの作成
- [ ] ブックマークURLをいくつか追加
- [ ] ワークスペースのアイコンの設定
  - `$ open xxxxxx.slack.com/customize/icon`
- [ ] ワークスペースにGitHubアプリを追加
  - `$ open xxxxxx.slack.com/apps/A01BP7R4KNY-github`
- [ ] 認証
  - `/github signin`
- [ ] subscribe
  - `/github subscribe {{owner}}/{{repository}}`
  - `/github subscribe {{owner}}/{{repository}} commits:'*'`
