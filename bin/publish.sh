#!/usr/bin/env bash
set -eu -o pipefail

# MacOS lover's, I did not forget you ;)
PROJECT_ROOT="$(cd -P "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"
cd "$PROJECT_ROOT/public"

git add --all
git commit -m "Auto-deploy $(git show --oneline -s $GIT_COMMIT)"

# Pushing to gh-pages branch
git push origin gh-pages
