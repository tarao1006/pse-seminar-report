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
cp /main.py ./main.py
python3 main.py --filename ${INPUT_REPORT_FILENAME} --target-directory ${INPUT_PREFIX}/${GITHUB_REF_NAME} --output-directory ${INPUT_DISTRIBUTION_BRANCH}/${GITHUB_REF_NAME}
rm main.py

git add ${INPUT_DISTRIBUTION_BRANCH}/${GITHUB_REF_NAME}
git commit -m ":tada: Compiled ${GITHUB_REF_NAME}/${INPUT_REPORT_FILENAME} [${timestamp}]"
git push
