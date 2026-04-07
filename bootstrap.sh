#!/bin/env bash

##################################################################
# This file is managed by Velocity team to configure common 
# tools and settings for Coder workspaces. Please do not edit this
# file directly. To make any future updates simpler, make your 
# custom  changes in bootstrap-user-specific.sh. 
##################################################################

set -e
cd "$(dirname "${BASH_SOURCE}")";

echo "Configuring Home directory..."
# Build exclude arguments from .homeignore file
EXCLUDE_ARGS=""
if [ -f ".homeignore" ]; then
    while IFS= read -r line; do
        # Skip empty lines and comments
        if [[ -n "$line" && ! "$line" =~ ^[[:space:]]*# ]]; then
            EXCLUDE_ARGS="$EXCLUDE_ARGS --exclude=$line"
        fi
    done < ".homeignore"
fi

rsync $EXCLUDE_ARGS -avh --omit-dir-times --no-perms . ~;

echo "Completed configuring Home directory!"


#!/bin/env bash
set -e

# Wait for brew to be fully installed by Coder workspace script
# This avoids brew lockfile conflicts during parallel execution
echo "Waiting for brew to be ready..."
for i in {1..120}; do
    if [ -f "/tmp/coder-brew-ready" ]; then
        echo "Brew is ready!"
        break
    fi
    sleep 2
done

if [ ! -f "/tmp/coder-brew-ready" ]; then
    echo "Warning: Brew installation marker not found, proceeding anyway..."
fi

if ! command -v brew &> /dev/null; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

brew install yq
echo "Cloning user repositories..."
if [ -f "config-user-specific.yaml" ]; then
  base_dir=$(yq eval '.auto-clone.base-dir' config-user-specific.yaml)
  mkdir -p "$base_dir"
  
  for repo in $(yq eval '.auto-clone.repositories[]' config-user-specific.yaml); do
    folder_name="${repo##*/}"
    if [ ! -d "$base_dir/$folder_name" ]; then
      echo "Cloning $repo into $base_dir/$folder_name..."
      git clone "$repo" "$base_dir/$folder_name"
    else
      echo "$folder_name already exists, skipping clone"
    fi
  done
else
  echo "Warning: config-user-specific.yaml not found, skipping repository cloning"
fi
echo "Completed cloning user repositories!"


echo "Installing tools..."
bash bootstrap-user-specific.sh
echo "Completed installing tools!"