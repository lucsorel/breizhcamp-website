#!/usr/bin/env bash
set -eu -o pipefail

# MacOS lover's, I did not forget you ;)
PROJECT_ROOT="$(cd -P "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"
cd "$PROJECT_ROOT"

groovy "$PROJECT_ROOT/bin/getSpeakers.groovy" | jq . > "$PROJECT_ROOT/data/speaker.json"

