#!/bin/sh -l

echo '\nGetting the code...\n'
git clone --quiet https://$INPUT_TOKEN@github.com/$GITHUB_REPOSITORY check
cd check
git checkout $BRANCH_SOURCE
rm .Rprofile

echo '\nSession info\n'
Rscript -e 'sessioninfo::session_info()'

echo '\nUpdate version number...\n'
git config --global user.email "info@inbo.be"
git config --global user.name "INBO"
UPDATED=$(Rscript -e 'protocolhelper::update_version_number("'$GITHUB_HEAD_REF'")')
echo 'output updated:' $UPDATED
if [ "$UPDATED" = "[1] TRUE" ]; then
  # remake the last commit without deletion of .Rprofile

  git push -f
  echo '\ncommit with new version pushed\n'
fi

echo '\nChecking protocols specific tests...\n'

Rscript "docker/check_all.R"
if [ $? -ne 0 ]; then
  echo '\nThe source code failed some checks. Please check the error message above.\n';
  exit 1
fi
