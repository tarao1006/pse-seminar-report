#!/bin/bash

git config user.name github-actions
git config user.email github-actions@github.com
git fetch --unshallow
git switch ${INPUT_DISTRIBUTION_BRANCH}
git merge ${GITHUB_REF_NAME}
COPY=false
if [[ ! -f .latexmkrc ]]; then
  COPY=true
  cp /.latexmkrc ./.latexmkrc
fi
latexmk ${INPUT_PREFIX}/${GITHUB_REF_NAME}/${INPUT_REPORT_FILENAME} -output-directory=${INPUT_DISTRIBUTION_BRANCH}/${GITHUB_REF_NAME}
if ${COPY}; then
  rm .latexmkrc
fi
git add .
git commit -m ":tada: Compiled ${GITHUB_REF_NAME}/${INPUT_REPORT_FILENAME} [${timestamp}]"
git push
