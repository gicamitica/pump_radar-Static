#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   GH_TOKEN=... ./push_to_github.sh gicamitica pumpradar-algo-lab
#   GH_TOKEN=... ./push_to_github.sh gicamitica pump_radar-Static https://github.com/gicamitica/pump_radar-Static.git

USERNAME="${1:-gicamitica}"
REPO_NAME="${2:-pumpradar-algo-lab}"
REMOTE_URL_INPUT="${3:-}"
TOKEN="${GH_TOKEN:-${GITHUB_TOKEN:-}}"

if [[ -z "$TOKEN" ]]; then
  echo "[ERROR] Missing GH_TOKEN (or GITHUB_TOKEN)."
  echo "Example: GH_TOKEN=ghp_xxx ./push_to_github.sh gicamitica pumpradar-algo-lab"
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if [[ -n "$REMOTE_URL_INPUT" ]]; then
  REMOTE_URL="$REMOTE_URL_INPUT"
  echo "[INFO] Using existing remote URL: $REMOTE_URL"
else
  # Create repo if missing
  HTTP_CODE=$(curl -sS -o /tmp/gh_repo_resp.json -w "%{http_code}" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Accept: application/vnd.github+json" \
    https://api.github.com/user/repos \
    -d "{\"name\":\"$REPO_NAME\",\"private\":true}")

  if [[ "$HTTP_CODE" == "201" ]]; then
    echo "[OK] Repo created: https://github.com/$USERNAME/$REPO_NAME"
  elif [[ "$HTTP_CODE" == "422" ]]; then
    echo "[INFO] Repo may already exist: https://github.com/$USERNAME/$REPO_NAME"
  else
    echo "[WARN] GitHub API response code: $HTTP_CODE"
    cat /tmp/gh_repo_resp.json || true
  fi

  REMOTE_URL="https://github.com/$USERNAME/$REPO_NAME.git"
fi

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REMOTE_URL"
else
  git remote add origin "$REMOTE_URL"
fi

# Push current branch
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
git push -u "https://$TOKEN@github.com/$USERNAME/$REPO_NAME.git" "$CURRENT_BRANCH"

echo "[DONE] Pushed branch '$CURRENT_BRANCH' to https://github.com/$USERNAME/$REPO_NAME"
