#!/usr/bin/env bash
set -eu -o pipefail

root_dir="$(cd -P "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

schedule_file="$root_dir/static/json/schedule.json"
if [[ -r "$schedule_file" ]]; then
  schedule="$(cat "$schedule_file")"
  echo "$schedule" |\
    jq 'sort_by(.id)' |\
    jq -f "$root_dir/bin/format-talks-json.jq" > "$schedule_file"
fi
