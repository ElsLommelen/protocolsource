#!/bin/sh -l

echo '\nGetting the code...\n'
git clone --quiet https://$INPUT_TOKEN@github.com/$GITHUB_REPOSITORY check
cd check
git checkout $BRANCH_SOURCE
ls -a
rm .Rprofile

echo '\nChecking protocols specific tests...\n'
rm .Rprofile
Rscript "docker/check_all.R"
if [ $? -ne 0 ]; then
  echo '\nThe source code failed some checks. Please check the error message above.\n';
  exit 1
fi
