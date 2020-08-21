#!/bin/bash

# Syntax quick-cherry-pick.sh commit-id dest-branch bug-id

# Author: Ketan Kulkarni
# June 2019

usage () {
    echo "quick-cherry-pick.sh <commit-id> <destination-branch> <bug-id>"
    echo "  This Script will
            1. Check if destination-branch exists
            2. is not out of sync with remote
            3. do the pull --rebase on destination-branch if required
            4. create a pvt branch to do the cherry-pick from bug-id and destination branch
            5. do the cherry-pick
            6. if cherry-pick succesful; it will push the pvt branch to remote"
    exit 1;
}

if [[ $# -ne 3 ]]; then
    usage
fi

COMMIT_ID=$1
DEST_BRANCH=$2
BUG=$3

handle_exit () {
    echo $1
    echo "Aborting Cherry-Pick"
    git status
    echo "Cherry-pick Aborted"
    exit 1
}

## Get to destination branch
# git fetch
# git checkout dest-branch
# git rev-parse

git fetch
git checkout ${DEST_BRANCH}

if [[ $? -ne 0 ]]; then
    handle_exit "${DEST_BRANCH} does not exist"
fi

UPSTREAM="origin/${DEST_BRANCH}"
LOCAL=$(git rev-parse ${DEST_BRANCH})
REMOTE=$(git rev-parse ${UPSTREAM})
BASE=$(git merge-base @ ${UPSTREAM})

if [[ $LOCAL = $REMOTE ]]; then
    echo "Local and Remote are up-to-date"
elif [[ $LOCAL = $BASE ]]; then
    echo "Updating the local repo"
    git stash
    git pull --rebase
    if [[ $? -ne 0 ]]; then
        handle_exit "Updating Local Repo Failed"
     fi
elif [[ $REMOTE = $BASE ]]; then
    handle_exit "Local has unmerged changes"
else
    handle_exit "Local and Remote have diverged"
fi

echo "Creating $BUG-$DEST_BRANCH branch"
git checkout -b ${BUG}-${DEST_BRANCH}

if [[ $? -ne 0 ]]; then
    handle_exit "Destination Branch Already Exists"
fi

echo "Cherry-picking $COMMIT_ID"
git cherry-pick -x ${COMMIT_ID}
ret=$?

if [[ $ret -ne 0 ]]; then
    echo "Cherry-picking failed"
    git status
    exit $ret
fi

echo "Cherry-pick successful"
git status

read -r -p "Do you want to push branch to remote? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        git push -u origin ${BUG}-${DEST_BRANCH}
        if [[ $? -ne 0 ]]; then
            echo "Git Push Branch to remote failed"
            git status
            exit 1
        fi
        echo "Git Push Successfull"
        ;;
    *)
        echo "Skipped.. Pushing branch to remote.."
        ;;
esac

echo "Done.. See you soon!"
exit 0
