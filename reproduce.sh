#!/usr/bin/env bash
# reproduce.sh — Artifact validation for corpus-guide
#
# The three JSON files in this repository (corpus-map.json, guide-routing.json,
# articles-map.json) are GENERATED PROJECTIONS of the private corpus substrate.
# They are regenerated upstream at emit time (with a public-safety screen) and
# are not rebuilt from sources inside this repository. This script therefore
# VALIDATES the shipped artifacts (well-formed JSON, non-empty, expected
# top-level keys) rather than regenerating them.
# Conforms to PUBLIC_MIRROR_STANDARD.md v1.0.0 (validation-orchestrator form).
#
# Usage:
#   ./reproduce.sh                  # Validate all JSON artifacts
#   ./reproduce.sh --check-only     # Verify dependencies only
#
# Run log lands in output/logs/validate_run.log

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT"

LOG_FILE="output/logs/validate_run.log"
mkdir -p output/figures output/tables output/logs

log() { echo "$@" | tee -a "$LOG_FILE"; }

log "=================================================="
log "Validation run: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
log "Repo: $REPO_ROOT"
log "Git SHA: $(git rev-parse HEAD 2>/dev/null || echo 'not-a-repo')"
log "=================================================="

CHECK_ONLY=0
for arg in "$@"; do
  case "$arg" in
    --check-only) CHECK_ONLY=1 ;;
    *) echo "Unknown flag: $arg"; exit 2 ;;
  esac
done

# 1. Dependency check: jq preferred, python3 fallback
JSON_TOOL=""
if command -v jq >/dev/null 2>&1; then
  JSON_TOOL="jq"
elif command -v python3 >/dev/null 2>&1; then
  JSON_TOOL="python3"
else
  log "FAIL: need jq or python3 for JSON validation"
  exit 1
fi
log "JSON tool: $JSON_TOOL"

if [ "$CHECK_ONLY" -eq 1 ]; then
  log "Dependency check passed (--check-only); exiting."
  exit 0
fi

# 2. Validate each artifact: well-formed, non-empty, expected top-level keys
FAIL=0

validate() {
  local file="$1"; shift
  local required_keys=("$@")
  if [ ! -s "$file" ]; then
    log "FAIL: $file missing or empty"
    FAIL=1
    return
  fi
  if [ "$JSON_TOOL" = "jq" ]; then
    if ! jq empty "$file" >/dev/null 2>&1; then
      log "FAIL: $file is not well-formed JSON"
      FAIL=1
      return
    fi
    for key in "${required_keys[@]}"; do
      if [ "$(jq --arg k "$key" 'has($k)' "$file")" != "true" ]; then
        log "FAIL: $file missing top-level key: $key"
        FAIL=1
        return
      fi
    done
  else
    if ! python3 - "$file" "${required_keys[@]}" <<'EOF'
import json, sys
path, keys = sys.argv[1], sys.argv[2:]
with open(path) as f:
    data = json.load(f)
missing = [k for k in keys if k not in data]
if missing:
    print(f"missing keys in {path}: {missing}")
    sys.exit(1)
EOF
    then
      log "FAIL: $file failed validation"
      FAIL=1
      return
    fi
  fi
  log "OK: $file"
}

validate corpus-map.json schema_version papers terms citation_edges
validate guide-routing.json schema_version roles fallback
validate articles-map.json schema_version by_article by_paper

if [ "$FAIL" -ne 0 ]; then
  log "VALIDATION FAILED"
  exit 1
fi

log "All artifacts valid."
log "Note: regeneration happens upstream against the private corpus substrate;"
log "this repository ships validated projections only."
