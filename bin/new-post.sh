#!/bin/bash
set -eux
cd $(dirname $0)/../

readonly post_title=$1
readonly author=$2
which gsed

echo "$post_title" > /tmp/post_title

git checkout master
git pull --ff-only origin master

hugo new post/"$post_title".md --editor=code
gsed -i -e "5i author: $author" content/post/"$post_title".md
gsed -i -e "3i slug: $post_title" content/post/"$post_title".md
