---
title: "WordPressをdocker-composeでサッとたてる"
slug: wordpress-docker-compose
date: 2020-11-27T17:05:07+09:00
draft: false
author: sakamossan
---

wordpressを手元でさくっと立ち上げたい時があったので、docker-composeでたててみた

`.docker` 配下にボリュームをつくってデータを永続化している

```yaml
version: "2"
services:
  wp:
    image: wordpress:latest
    restart: always
    volumes:
      - ".docker/wp/var/www/html:/var/www/html"
    ports:
      - "127.0.0.1:8000:80"
    depends_on:
      - db
    environment:
      WORDPRESS_DB_HOST: "db:3306"
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress

  db:
    image: mysql:5.7
    restart: always
    volumes:
      - ".docker/db/var/lib/mysql:/var/lib/mysql"
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
```

## 参考

- [クィックスタート: Compose と WordPress — Docker-docs-ja 17.06 ドキュメント](https://docs.docker.jp/compose/wordpress.html)
- [Compose ファイル・リファレンス — Docker-docs-ja 17.06 ドキュメント](https://docs.docker.jp/compose/compose-file.html#volumes-volume-driver)
