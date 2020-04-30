#!/bin/bash
set -eux
cd $(dirname $0)/../
readonly post_title=$(cat /tmp/post_title)

git pull --ff-only origin master
(cd public; git pull --ff-only origin master)
hugo

pushd public
    git add .
    git commit -m $post_title
    git push origin master
popd

git add .
git commit -m $post_title
git push origin master

pushd ~/.ghq/github.com/sakamossan/services/blog.n-t.jp
    cp ~/.ghq/github.com/dream-yt/sacre/content/post/$post_title.md content/
    scripts/deploy.sh
popd
