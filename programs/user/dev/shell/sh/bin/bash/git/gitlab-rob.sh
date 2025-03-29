#!/bin/bash

if [[ -z "$AZURE_ORG" || -z "$AZURE_PROJECT" || -z "$GITLAB_GROUP_ID" ]]; then
    echo "Error: Missing environment variables."
    echo "Ensure AZURE_ORG, AZURE_PROJECT, and GITLAB_GROUP_ID are set."
    exit 1
fi


echo "Authenticating with Azure DevOps..."
az devops configure --defaults organization="https://dev.azure.com/$AZURE_ORG" project="$AZURE_PROJECT"

echo "Fetching repositories from Azure DevOps..."
REPOS=$(az repos list --query "[].{name:name, cloneUrl:remoteUrl}" -o json)

if [[ "$REPOS" == "[]" ]]; then
    echo "No repositories found in Azure DevOps project: $AZURE_PROJECT"
    exit 1
fi

echo "$REPOS" | jq -c '.[]' | while read -r repo; do
    REPO_NAME=$(echo "$repo" | jq -r '.name')
    echo "Processing repository: $REPO_NAME"

    if glab repo view "$GITLAB_GROUP_ID/$REPO_NAME" &>/dev/null; then
        echo "Repository $REPO_NAME already exists in GitLab. Skipping..."
        continue
    fi

    echo "Cloning $REPO_NAME from Azure DevOps..."
    git clone "git@ssh.dev.azure.com:v3/${AZURE_ORG}/${AZURE_PROJECT}/$REPO_NAME"
    cd "$REPO_NAME" || exit

    git branch -r | grep -v '\->' | while read -r remote; do
        git branch --track "${remote#origin/}" "$remote" || true
    done

    export NO_PROMPT=1
    glab repo create "$REPO_NAME" --private --group "$GITLAB_GROUP_ID"

    git remote add gitlab "git@gitlab.com:$GITLAB_GROUP_ID/$REPO_NAME.git"
    git push --all gitlab

    cd ..
    rm -rf "$REPO_NAME"

    echo "Successfully migrated $REPO_NAME to GitLab."
done

echo "Migration completed!"
