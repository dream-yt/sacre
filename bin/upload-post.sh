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

(test -d ~/.ghq/github.com/sakamossan/services/next-blog.n-t.jp \
    && cd $_ \
    && npm run deploy)
