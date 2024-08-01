#!/usr/bin/env bash

# Received via command line
git_project_name=$1

git_source_owner=placeholder
git_source_org=placeholder
git_dest_owner=placeholder
git_dest_project=placeholder

echo $git_project_name
git clone git@${git_source_owner}:${git_source_org}/${git_project_name}.git
cd ${git_project_name}

git branch -r | grep -v '\->' | while read remote; do
git branch --track "${remote#origin/}" "$remote"
done

# Default: SSH Azure Repos
git remote set-url origin git@ssh.dev.azure.com:v3/${git_dest_owner}/${git_dest_project}/$(basename $(git rev-parse --show-toplevel))

git push --all origin

cd ..
echo "Git rob finished for project ${git_project_name}!"
