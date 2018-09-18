#!/usr/bin/env bash
#
# Check if commit msg contains Jira's story-id.
# Prepend it, if it's missing.

# A few exceptions: do not prepend story-id if:
# - commit msg already starts with IN-[0-9]+
# - commit msg starts with `fixup` or `squash`
# - .git/sequencer exists (whenever there's a cherry-pick or revert)
# - .git/rebase-(apply|merge) exists

set -e

branch=$(git symbolic-ref --short HEAD)
story=$(sed -E 's/(I[NT]-[0-9]+){0,1}.*/\1/' <<< $branch)

if [[ -z $story ]]; then
   echo "Branch does not contain any IN reference"
   exit 1
fi

if [[ ! $(head -n1 $1) =~ ^(\[IN-[0-9]+\]|fixup|squash) ]] &&
   [[ ! -d "$GIT_DIR/rebase-merge" ]] &&
   [[ ! -d "$GIT_DIR/rebase-apply" ]] &&
   [[ ! -d "$GIT_DIR/sequencer" ]]; then
   sed -i.bak -e "1s/^/[${story}] /" $1
fi
