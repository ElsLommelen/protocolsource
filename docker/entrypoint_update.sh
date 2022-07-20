#!/bin/sh -l

echo '\nGetting the code...\n'
git clone --branch=$BRANCH_SOURCE https://$INPUT_TOKEN_INBO@github.com/$GITHUB_REPOSITORY /update
git config --global user.email "info@inbo.be"
git config --global user.name "INBO"
cd /update
#git checkout $BRANCH_SOURCE
ls -a
rm .Rprofile

echo '\nUpdating zenodo...\n'
Rscript --no-save --no-restore -e 'protocolhelper:::update_zenodo()'
git add --all
git commit --message="update .zenodo.json"

echo '\nUpdating general NEWS.md...\n'
Rscript --no-save --no-restore -e 'protocolhelper:::update_news_release("'$PROTOCOL_CODE'")'
#git config user.name
#git config user.email
git add --all
git commit --message="update general NEWS.md"

echo 'git config --list:'
git config --list

echo 'git branch'
git branch

echo 'git remote -v show origin'
git remote -v show origin

echo 'git push'
git push -f
