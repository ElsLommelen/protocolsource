#!/bin/sh -l

echo '\nGetting the code...\n'
git clone --quiet https://$INPUT_TOKEN@github.com/$GITHUB_REPOSITORY check
cd check
git checkout $BRANCH_SOURCE
#ls -a
rm .Rprofile

#echo '\nChecking if branch is up to date with main...\n'
#main_in_branch=$(git merge-base $BRANCH_SOURCE main)
#echo $main_in_branch
#git checkout main
#git pull
#head_main=$(git rev-parse HEAD)
#echo $head_main
#if [ $main_in_branch != $head_main ]; then
#  echo '\nThis branch does not contain the latest version of the main branch. Please merge the main branch into this branch first\n';
#  exit 1
#fi

echo '\nChecking protocols specific tests...\n'
#git checkout $BRANCH_SOURCE
#rm .Rprofile

Rscript "docker/check_all.R"
#Rscript --no-save --no-restore -e 'check_all("'$PROTOCOL_CODE'")'
if [ $? -ne 0 ]; then
  echo '\nThe source code failed some checks. Please check the error message above.\n';
  exit 1
fi

# Rscript 'protocolhelper::check_frontmatter("'$PROTOCOL_CODE'")'
# test1=$?
# Rscript -e 'protocolhelper::check_structure("'$PROTOCOL_CODE'")'
# test2=$?
# 
# if [ $test1 -ne 0 ] || [ $test2 -ne 0 ]; then
#   #echo $error1
#   echo '\nThe source code failed some checks. Please check the error message above.\n';
#   exit 1
# fi
