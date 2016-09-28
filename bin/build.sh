#!/usr/bin/env bash
set -eu -o pipefail

# MacOS lover's, I did not forget you ;)
PROJECT_ROOT="$(cd -P "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"
cd "$PROJECT_ROOT"

HUGO=$(which hugo) || not_found=$?
if [[ $not_found -ne 0 ]]; then
  if [[ ! -d .hugo ]]; then
    mkdir .hugo
    curl -L https://github.com/spf13/hugo/releases/download/v0.15/hugo_0.15_linux_amd64.tar.gz | \
      (cd .hugo; tar xzf -)
  fi
  HUGO=".hugo/hugo_0.15_linux_amd64/hugo_0.15_linux_amd64"
fi

REPO="git@github.com:breizhcamp/www-staging.git"

for i in "$@"; do
  case $1 in
    -p|--prod)
      REPO="git@github.com:breizhcamp/www-2017.git"
      ;;
    *)
      break
      ;;
  esac
done

if [[ ! -d public ]]; then
  git clone -b gh-pages "$REPO" public
else
  ORIGIN_URL=$(git config --get remote.origin.url)
  if [[ "$REPO" != "$ORIGIN_URL" ]]; then
    rm -rf public
    git clone -b gh-pages "$REPO" public
  fi
  (cd public; git clean -fdx; git checkout .)
fi

$HUGO
