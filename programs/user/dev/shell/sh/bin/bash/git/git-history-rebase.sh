#!/usr/bin/env bash

## VARS
MAIN_BRANCH_NAME="master"
FEAT_BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)


## FUNCS
create_branch_backup() {
    echo "Would you like to create a backup branch, before rebasing? [y/n]"
    read -r -n 1 choice
    if [[ $choice == "y" ]]; then
        git branch "$FEAT_BRANCH_NAME-bak"
        echo -e "\nBackup branch: $FEAT_BRANCH_NAME-bak created!"
    fi
}

prompt_to_rebase() {
    create_branch_backup

    echo -e "I've found the first sha commit on feature branch: $first_sha_commit\n Please press ENTER if this is the case..."
    read -r

    echo -e "Now you'll be prompted to rebase all of those commits:\n> Replace all 'pick' with 'squash'.\n> Leave only the first commit with 'pick'.\n\nPress ENTER to continue"
    read -r
}

cherry_pick() {
    echo "Performing cherry picking then..."

    local rebased_sha_commit
    rebased_sha_commit="$(git rev-parse HEAD)"
    echo -e "I've found the rebased sha commit: $rebased_sha_commit\n Please press ENTER if this is the case..."
    read -r actual_sha_commit

    if [[ -n "$actual_sha_commit" ]]; then
        rebased_sha_commit="$actual_sha_commit"
    fi
    local clean_branch_name
    clean_branch_name="$FEAT_BRANCH_NAME-clean"

    git checkout "$MAIN_BRANCH_NAME"
    git pull "$MAIN_BRANCH_NAME"
    git checkout -b "$clean_branch_name"
    git cherry-pick "$rebased_sha_commit"

    git add .
    git commit -m "performed cherry picking from commit: $rebased_sha_commit"
    git push --set-upstream origin "$clean_branch_name"
}

commit() {
    git add .
    git commit -m "$1"
    git fetch origin
    git merge "origin/$FEAT_BRANCH_NAME"
    git commit -m "Fetch changes from remote"
    git push origin "$FEAT_BRANCH_NAME"
}

rebase_continue() {
    while true; do
        git add .
        git rebase --continue

        echo -e "\n\n"
        echo "Press [f] if rebasing is finished successfully"
        read -r -n 1 -p "Continue [y/n]: " stop

        if [[ $stop == "n" ]]; then
            exit 1
        elif [[  $stop == "f" ]]; then
            break
        fi
    done
}


## MAIN

first_sha_commit=$(git cherry "$MAIN_BRANCH_NAME" -v | head -n 1 | awk '{print $2;}')
prompt_to_rebase "$first_sha_commit"

## Check if user is in rebasing
if [ -d .git/rebase-merge ] || [ -d .git/rebase-apply ]; then
    rebase_continue
else
    # Start rebasing
    git rebase -i "$first_sha_commit" || {
        rebase_continue
    }
fi

echo -e "\n\nOk rebasing done. Now please confirm if we are ready to push by pressing ENTER."
read -r

commit "Performed rebase commit"
echo -e "\n\nIf for some reason your feature branch is based on another feature branch, it's best to create a fresh new branch and cherry pick the old one.\n\n Confirm: [y/n]"
read -n 1 -r option

if [[ $option == 'y' ]]; then
    cherry_pick
fi

echo -e "\n\nOperation finished!"


