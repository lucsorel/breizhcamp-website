#!/usr/bin/env bash
set -eu -o pipefail

# MacOS lover's, I did not forget you ;)
PROJECT_ROOT="$(cd -P "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"
cd "$PROJECT_ROOT"

REPO="git@github.com:breizhcamp/www-staging.git"

for i in "$@"; do
  case $1 in
    -p|--prod)
      REPO="git@github.com:breizhcamp/www-2018.git"
      sed -i 's|^baseurl.*$|baseurl = "http://www.breizhcamp.org/"|' config.toml
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

"$PROJECT_ROOT/hugow"
