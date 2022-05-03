#!/bin/sh

NAME=${1:-}

if [ -z ${NAME} ]; then
  echo "First argument needs to be a valid name. Quitting!" >&2
  exit 1
fi

cd /tmp
mkdir myrepo
cd myrepo
git init --shared=true
touch README.md
git add .
git commit -m "first commit"
cd ..
git clone --bare myrepo /git-server/repos/$NAME.git
rm -Rf /tmp/myrepo
