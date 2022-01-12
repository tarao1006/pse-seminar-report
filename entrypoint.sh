#!/bin/bash

timestamp=`date "+%s"`

git config user.name github-actions
git config user.email github-actions@github.com
git fetch --unshallow
git switch ${INPUT_DISTRIBUTION_BRANCH}
git merge ${GITHUB_REF_NAME}

if [[ -f .latexmkrc ]]; then
  cp .latexmkrc $HOME/.latexmkrc
else
  cp /.latexmkrc $HOME/.latexmkrc
fi
PWD=`pwd`
cd ${INPUT_PREFIX}/${GITHUB_REF_NAME}
latexmk ${INPUT_REPORT_FILENAME} -output-directory=${PWD}/${INPUT_DISTRIBUTION_BRANCH}/${GITHUB_REF_NAME}
cd -

git add ${INPUT_DISTRIBUTION_BRANCH}/${GITHUB_REF_NAME}
git commit -m ":tada: Compiled ${GITHUB_REF_NAME}/${INPUT_REPORT_FILENAME} [${timestamp}]"
git push
