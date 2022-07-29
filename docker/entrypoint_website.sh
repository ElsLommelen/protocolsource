#!/bin/sh -l

echo '\nGetting the code...\n'
git clone --quiet https://$INPUT_TOKEN@github.com/$GITHUB_REPOSITORY_SOURCE /render
cd /render
git checkout $BRANCH_SOURCE
git config --global user.email "info@inbo.be"
git config --global user.name "INBO"

rm .Rprofile

echo '\nSession info\n'
#Rscript -e "renv::restore()"
Rscript -e 'sessioninfo::session_info()'

echo '\nAdd tag to merge commit protocolsource...\n'
echo 'GitHub actions:' $GITHUB_ACTIONS
echo 'Event name:' $GITHUB_EVENT_NAME
echo 'ref:' $GITHUB_REF
git rev-parse --abbrev-ref origin/HEAD | sed 's/origin\///' | xargs git checkout
Rscript --no-save --no-restore -e 'protocolhelper:::set_tags("'$PROTOCOL_CODE'")'
git push --follow-tags

echo 'Rendering the Rmarkdown files...\n'
#rm .Rprofile
Rscript -e "protocolhelper:::render_release()"
if [ $? -ne 0 ]; then
  echo '\nRendering failed. Please check the error message above.\n';
  exit 1
else
  echo '\nAll Rmarkdown files rendered successfully\n'
fi

echo 'Publishing the rendered files...\n'
git clone --quiet --depth=1 --single-branch --branch=main https://$INPUT_TOKEN@github.com/$GITHUB_REPOSITORY_DEST /destiny
#git config --global user.email "info@inbo.be"
#git config --global user.name "INBO"

cp -R /render/publish/. /destiny/.
cd /destiny
ls -a

git config user.name
git config user.email
git add --all
git commit --message="Add new protocol"
Rscript --no-save --no-restore -e 'protocolhelper:::set_tags("'$PROTOCOL_CODE'")'
git push -f https://$INPUT_TOKEN@github.com/$GITHUB_REPOSITORY_DEST

echo '\nNew version published...'
