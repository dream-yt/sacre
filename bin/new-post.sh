#!/bin/bash
set -eux
cd $(dirname $0)/../

readonly post_title=$1

echo "$post_title" > /tmp/post_title

git checkout master
git pull --ff-only origin master

hugo new post/"$post_title".md --editor=code
