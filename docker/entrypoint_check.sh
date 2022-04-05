#!/bin/sh -l

echo '\nGetting the code...\n'
git clone --quiet https://$INPUT_TOKEN@github.com/$GITHUB_REPOSITORY check
cd check
git checkout $BRANCH_SOURCE
ls -a
rm .Rprofile

echo '\nDoing checklist tests...\n'
Rscript --no-save --no-restore -e 'checklist::check_source(protocolhelper:::get_path_to_protocol("'$PROTOCOL_CODE'"))'
if [ $? -ne 0 ]; then
  echo '\nThe source code failed some checklist checks. Please check the error message above.\n';
fi

echo '\nChecking frontmatter...\n'
Rscript "docker\check_all.R"
Rscript --no-save --no-restore -e 'check_all("'$PROTOCOL_CODE'")'
if [ $? -ne 0 ]; then
  echo '\nThe source code failed some checks. Please check the error message above.\n';
  exit 1
fi

echo '\nChecking document structure...\n'
#Rscript --no-save --no-restore -e 'protocolhelper::check_structure("'$PROTOCOL_CODE'"")'
if [ $? -ne 0 ]; then
  echo '\nThe source code failed some structure checks. Please check the error message above.\n';
  exit 1
fi

#nog aanpass
