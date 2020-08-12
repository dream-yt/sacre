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

readonly dir="$HOME/.ghq/github.com/sakamossan/services/next-blog.n-t.jp"
if [ -d $dir ]; then
    pushd $dir
        direnv exec . npm run deploy
    popd
fi
