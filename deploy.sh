#!/bin/bash

TARGET=dist

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
rm -rf $TARGET
gulp build

# Add changes to git.
git add -A

# Commit changes.
msg="Rebuilds site and deploys to gh-pages `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master --force

# git subtree add --prefix=$TARGET git@github.com:blackbird/blackbirdstudios.io.git master --squash
# git subtree push --force --prefix=$TARGET git@github.com:blackbird/blackbirdstudios.io.git gh-pages
git push origin `git subtree split --prefix $TARGET master`:gh-pages --force
