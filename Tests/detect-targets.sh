#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/.." && pwd)"
mode=""
base=""
head="HEAD"
requested_app=""

usage() {
  cat <<'EOF'
Usage:
  detect-targets.sh [--repo DIR] --mode all
  detect-targets.sh [--repo DIR] --mode app --app NAME
  detect-targets.sh [--repo DIR] --mode changed --base SHA [--head SHA]
EOF
}

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

while (($# > 0)); do
  case "$1" in
    --app)
      (($# >= 2)) || fail "--app requires a value"
      requested_app="$2"
      shift 2
      ;;
    --base)
      (($# >= 2)) || fail "--base requires a value"
      base="$2"
      shift 2
      ;;
    --head)
      (($# >= 2)) || fail "--head requires a value"
      head="$2"
      shift 2
      ;;
    --mode)
      (($# >= 2)) || fail "--mode requires a value"
      mode="$2"
      shift 2
      ;;
    --repo)
      (($# >= 2)) || fail "--repo requires a value"
      repo_dir="$(cd "$2" && pwd)"
      shift 2
      ;;
    -h | --help)
      usage
      exit 0
      ;;
    *)
      fail "unknown argument: $1"
      ;;
  esac
done

is_valid_app_name() {
  [[ "$1" =~ ^[a-z0-9][a-z0-9@+._-]*$ ]]
}

all_spec_apps() {
  local spec

  for spec in "$repo_dir"/Tests/spec/*_spec.sh; do
    [[ -e "$spec" ]] || continue
    basename "$spec" _spec.sh
  done
}

validate_app() {
  local app="$1"
  local formula="$repo_dir/Formula/$app.rb"
  local cask="$repo_dir/Casks/$app.rb"
  local spec="$repo_dir/Tests/spec/${app}_spec.sh"
  local definition_count=0

  is_valid_app_name "$app" || fail "invalid app name: $app"
  [[ -f "$formula" ]] && ((definition_count += 1))
  [[ -f "$cask" ]] && ((definition_count += 1))

  ((definition_count > 0)) || fail "no Formula or Cask found for: $app"
  ((definition_count == 1)) || fail "both Formula and Cask exist for: $app"
  [[ -f "$spec" ]] || fail "missing smoke-test spec: Tests/spec/${app}_spec.sh"
}

declare -a apps=()

case "$mode" in
  all)
    while IFS= read -r app; do
      apps+=("$app")
    done < <(all_spec_apps)
    ;;
  app)
    [[ -n "$requested_app" ]] || fail "--app is required in app mode"
    apps=("$requested_app")
    ;;
  changed)
    [[ -n "$base" ]] || fail "--base is required in changed mode"

    if [[ "$base" =~ ^0+$ ]] || ! git -C "$repo_dir" cat-file -e "${base}^{commit}" 2>/dev/null; then
      while IFS= read -r app; do
        apps+=("$app")
      done < <(all_spec_apps)
    else
      declare -a changed_files=()
      while IFS= read -r file; do
        changed_files+=("$file")
      done < <(git -C "$repo_dir" diff --name-only --diff-filter=ACMRTD "$base" "$head")

      run_all=false
      for file in "${changed_files[@]}"; do
        case "$file" in
          Formula/*.rb | Casks/*.rb)
            apps+=("$(basename "$file" .rb)")
            ;;
          Tests/spec/*_spec.sh)
            app="$(basename "$file" _spec.sh)"
            apps+=("$app")
            ;;
          .github/workflows/smoke-test.yml | Tests/detect-targets.sh | \
            Tests/run-smoke-test.sh | Tests/spec/spec_helper.sh | Tests/.shellspec)
            run_all=true
            ;;
        esac
      done

      if [[ "$run_all" == true ]]; then
        apps=()
        while IFS= read -r app; do
          apps+=("$app")
        done < <(all_spec_apps)
      fi
    fi
    ;;
  *)
    usage >&2
    fail "--mode must be one of: all, app, changed"
    ;;
esac

if ((${#apps[@]} == 0)); then
  printf '[]\n'
  exit 0
fi

declare -a sorted_apps=()
while IFS= read -r app; do
  sorted_apps+=("$app")
done < <(printf '%s\n' "${apps[@]}" | LC_ALL=C sort -u)
apps=("${sorted_apps[@]}")

for app in "${apps[@]}"; do
  validate_app "$app"
done

printf '['
separator=""
for app in "${apps[@]}"; do
  printf '%s"%s"' "$separator" "$app"
  separator=","
done
printf ']\n'
