#!/bin/sh -l

echo '\nGetting the code...\n'
git clone --quiet https://$INPUT_TOKEN@github.com/$GITHUB_REPOSITORY_SOURCE /render
cd /render
git checkout $BRANCH_SOURCE

echo 'Rendering the Rmarkdown files...\n'
rm .Rprofile
Rscript "docker/render.R"
if [ $? -ne 0 ]; then
  echo '\nRendering failed. Please check the error message above.\n';
  exit 1
fi
echo '\nAll Rmarkdown files rendered successfully\n'

echo 'Publishing the rendered files...\n'
git clone --quiet --depth=1 --single-branch --branch=main https://$INPUT_TOKEN@github.com/$GITHUB_REPOSITORY_DEST /destiny
git config --global user.email "info@inbo.be"
git config --global user.name "INBO"

cp -R /render/publish/. /destiny/.
cd /destiny
ls -a

git config user.name
git config user.email
git add --all
git commit --message="Add new protocol"
git push -f https://$INPUT_TOKEN@github.com/$GITHUB_REPOSITORY_DEST

echo '\nNew version published...'
