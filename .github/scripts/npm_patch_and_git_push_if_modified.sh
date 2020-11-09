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

git config --global user.email "$USER_EMAIL"
git config --global user.name "$USER_NAME"

mkdir -p ~/.ssh/
ssh-keyscan github.com >> ~/.ssh/known_hosts

BRANCH=$(git rev-parse --abbrev-ref HEAD)
git add . -A
git commit -m "$MESSAGE"
echo "Pushing branch $BRANCH"
git push origin HEAD:$BRANCH