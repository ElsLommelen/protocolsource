#!/bin/sh -l

echo '\nGetting the code...\n'
git clone --quiet https://$INPUT_TOKEN@github.com/$GITHUB_REPOSITORY check
cd check
git checkout $BRANCH_SOURCE
ls -a
rm .Rprofile

echo '\nUpdating zenodo...\n'
Rscript "protocolhelper:::update_zenodo()"
git config user.name
git config user.email
git add --all
git commit --message="update .zenodo.json"
git push -f https://$INPUT_TOKEN@github.com/$GITHUB_REPOSITORY

echo '\nUpdating general NEWS.md...\n'
Rscript "protocolhelper:::update_news_release(Sys.getenv("PROTOCOL_CODE"))"
git config user.name
git config user.email
git add --all
git commit --message="update general NEWS.md"
git push -f https://$INPUT_TOKEN@github.com/$GITHUB_REPOSITORY
