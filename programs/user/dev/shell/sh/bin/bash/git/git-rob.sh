#!/usr/bin/env bash

# Received via command line
git_project_name=$1

# shellcheck disable=SC2153
git_source_owner="${GIT_SOURCE_OWNER}"
git_source_org="${GIT_SOURCE_ORG}"
git_dest_owner="${GIT_DEST_OWNER}"
git_dest_project="${GIT_DEST_PROJECT}"
git_dest_ssh_domain="${GIT_DEST_SSH_DOMAIN}"

does_git_source_repo_exist=$(gh search repos "${git_project_name}" --owner="${git_source_org}" | head -1 )
# Commented due to taking too long
# does_git_dest_repo_exist=$(az repos show --repository testarino --detect false --org https://${git_dest_ssh_domain}/${git_dest_owner}/ -p ${git_dest_project})

if [ -z "$does_git_source_repo_exist" ]; then
    echo "Source repo: $git_project_name doesn't exist!"
else

    echo "Now starting the rob process: $git_project_name"
    az repos create --name "${git_project_name}" --detect false --org "https://${git_dest_ssh_domain}/${git_dest_owner}/" -p "${git_dest_project}"

    git clone "git@${git_source_owner}:${git_source_org}/${git_project_name}.git"
    cd "${git_project_name}"

    git branch -r | grep -v '\->' | while read -r remote; do
        git branch --track "${remote#origin/}" "$remote"
    done

    # Default: SSH Azure Repos
    git remote set-url origin "git@ssh.${git_dest_ssh_domain}:v3/${git_dest_owner}/${git_dest_project}/$(basename "$(git rev-parse --show-toplevel)")"

    git push --all origin

    cd ..
    echo "Git rob finished for project ${git_project_name}!"

fi

# Prerequisites
# ###########
# Dependencies
# GH CLI
# Az CLI + Az DevOps extension
# gh auth login # command
# az devops login # command
# #######
# Usage
# git-rob <REPO-NAME>
