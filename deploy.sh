#!/usr/bin/env bash
set -e # halt script on error

# master's sha
export GIT_SHA=`git rev-parse --short HEAD`

# git clone from gh-pages
git clone --depth=2 --branch=gh-pages https://${GH_TOKEN}@github.com/${GH_REF} ${HTML_FOLDER}

# build
bundle exec jekyll build
# bundle exec travis-lint
# bundle exec htmlproof ${HTML_FOLDER} --disable-external

# change workdir
cd ${HTML_FOLDER}

# config
git config --global user.email "lee@hwasub.com"
git config --global user.name "Hwasub Lee"

# git commit
git add --all
git commit -m "Deploy master:${GIT_SHA} on GitHub Pages"
git push --force --quiet "https://${GH_TOKEN}@github.com/${GH_REF}" gh-pages:gh-pages