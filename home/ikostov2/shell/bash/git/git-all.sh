#!/usr/bin/env bash

git_message=$1

git add .

git commit -m ${git_message}

( git push \
	|| git push --set-upstream origin \
	$(git rev-parse --abbrev-ref HEAD) )

