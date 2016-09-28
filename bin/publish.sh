#!/usr/bin/env bash
set -eu -o pipefail

# MacOS lover's, I did not forget you ;)
PROJECT_ROOT="$(cd -P "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"
cd "$PROJECT_ROOT/public"

if [[ -z $GIT_COMMIT ]]; then
  GIT_COMMIT=$(cd ..; git rev-parse --verify HEAD)
fi

git add --all
git commit -m "Deploy $(cd ..; echo -n "breizhcamp/website@"; git show --oneline -s $GIT_COMMIT)"

# Pushing to gh-pages branch
git push origin gh-pages
