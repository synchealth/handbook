#!/usr/bin/env bash

set -e

modified_files="$(git status --porcelain)"

if [ -z "${modified_files}" ] ; then
echo "There are no updated files"
exit 0
fi

echo "\nThere are modified files:"
echo "${modified_files}\n"

# npm version patch --no-git-tag-version

git config --global user.email "ci@sync.health"
git config --global user.name "Sync Health CI"

mkdir -p ~/.ssh/
ssh-keyscan github.com >> ~/.ssh/known_hosts

BRANCH=$(git rev-parse --abbrev-ref HEAD)
git add . -A
git commit -m "publish from Sync Studio"
echo "Pushing branch $BRANCH"
git push origin HEAD:$BRANCH