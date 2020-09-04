#!/usr/bin/env bash

set -e

modified_files="$(git status --porcelain)"

if [ -z "${modified_files}" ] ; then
echo "There are no updated files"
exit 0
fi

echo "\nThere are modified files:"
echo "${modified_files}\n"

npm version patch --no-git-tag-version

BRANCH=$(sh ./scripts/print_git_branch.sh)
git add . -A
git commit -m "auto-publish after sync from SharePoint/OneDrive [ci skip] [skip ci]"
echo "Pushing branch $BRANCH"
git push origin HEAD:$BRANCH