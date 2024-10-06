#!/usr/bin/env bash

IFS=' '
git_message="$*"

git add .
git commit -m "${git_message}"

( git push || git push --set-upstream origin "$(git rev-parse --abbrev-ref HEAD)" )

