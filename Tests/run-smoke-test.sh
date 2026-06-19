#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/.." && pwd)"
app="${1:-}"

if [[ -z "$app" ]]; then
  echo "Usage: run-smoke-test.sh APP" >&2
  exit 1
fi

formula="$repo_dir/Formula/$app.rb"
cask="$repo_dir/Casks/$app.rb"
spec="$repo_dir/Tests/spec/${app}_spec.sh"
definition_count=0

[[ -f "$formula" ]] && ((definition_count += 1))
[[ -f "$cask" ]] && ((definition_count += 1))

if ((definition_count == 0)); then
  echo "ERROR: no Formula or Cask found for: $app" >&2
  exit 1
fi
if ((definition_count > 1)); then
  echo "ERROR: both Formula and Cask exist for: $app" >&2
  exit 1
fi
if [[ ! -f "$spec" ]]; then
  echo "ERROR: missing smoke-test spec: Tests/spec/${app}_spec.sh" >&2
  exit 1
fi

install_log="$(mktemp)"
trap 'rm -f "$install_log"' EXIT

set +e
brew install --verbose "KEINOS/apps/$app" 2>&1 | tee "$install_log"
install_status=${PIPESTATUS[0]}
set -e

if ((install_status != 0)); then
  if grep -Fq "Broken pipe" "$install_log"; then
    echo "Retrying Homebrew install after a transient broken pipe..." >&2
    brew install --verbose "KEINOS/apps/$app"
  else
    exit "$install_status"
  fi
fi

if [[ -f "$cask" ]]; then
  brew list --cask "$app" >/dev/null
else
  brew list --formula "$app" >/dev/null
fi

(
  cd "$repo_dir/Tests"
  shellspec "./spec/${app}_spec.sh"
)
