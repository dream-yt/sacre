#!/bin/bash
set -eux
cd $(dirname $0)/../

git pull --ff-only origin master
(cd public; git pull --ff-only origin master)

readonly post_title=$(cat /tmp/post_title)
hugo

pushd public
    git add .
    git commit -m $post_title
    git push origin master
popd

git add .
git commit -m $post_title
git push origin master