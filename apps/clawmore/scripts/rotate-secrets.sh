#!/usr/bin/env bash
set -euo pipefail

# ClawMore Secret Rotation Helper
# Usage: ./scripts/rotate-secrets.sh [--dry-run]

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=true
  echo "[DRY RUN] No commands will be executed."
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
ENV_FILE="$PROJECT_ROOT/.env"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[ROTATE]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
err() { echo -e "${RED}[ERROR]${NC} $*" >&2; }

# ──────────────────────────────────────────────
# 1. Remove any tracked env files from git cache
# ──────────────────────────────────────────────
log "Checking for tracked env files..."
TRACKED_ENV_FILES=$(git -C "$PROJECT_ROOT" ls-files --cached '.env*' 2>/dev/null || true)

if [[ -n "$TRACKED_ENV_FILES" ]]; then
  warn "Found tracked env files:"
  echo "$TRACKED_ENV_FILES"
  if [[ "$DRY_RUN" == true ]]; then
    warn "[DRY RUN] Would run: git rm --cached $TRACKED_ENV_FILES"
  else
    git -C "$PROJECT_ROOT" rm --cached $TRACKED_ENV_FILES
    log "Removed tracked env files from git index."
  fi
else
  log "No tracked env files found. Good."
fi

# ──────────────────────────────────────────────
# 2. List secrets that need rotation
# ──────────────────────────────────────────────
echo ""
log "========================================="
log " SECRETS REQUIRING ROTATION"
log "========================================="
echo ""

declare -A ROTATION_COMMANDS

ROTATION_COMMANDS[STRIPE_SECRET_KEY]="
  # Stripe: rotate via Stripe Dashboard or CLI
  stripe keys create --name 'clawmore-rotated' \\
  # Then update STRIPE_SECRET_KEY in .env"

ROTATION_COMMANDS[STRIPE_WEBHOOK_SECRET]="
  # Stripe webhook: create new endpoint signing secret
  stripe webhook-endpoints create \\
    --url https://clawmore.ai/api/stripe/webhook \\
    --events 'checkout.session.completed,payment_intent.succeeded'"

ROTATION_COMMANDS[NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY]="
  # Stripe publishable key is derived from the same account as STRIPE_SECRET_KEY
  # Retrieve after rotating STRIPE_SECRET_KEY:
  stripe keys list"

ROTATION_COMMANDS[AUTH_SECRET]="
  # Generate new auth secret locally:
  openssl rand -base64 32"

ROTATION_COMMANDS[NEXTAUTH_SECRET]="
  # Same as AUTH_SECRET - copy value from AUTH_SECRET"

ROTATION_COMMANDS[AWS_REGION]="
  # AWS: verify region is correct, rotate IAM credentials via:
  aws iam create-access-key --user-name <your-iam-user>
  # Then delete old key:
  aws iam delete-access-key --user-name <your-iam-user> --access-key-id <OLD_KEY_ID>"

ROTATION_COMMANDS[GITHUB_CLIENT_SECRET]="
  # GitHub OAuth: regenerate in GitHub Developer Settings
  # https://github.com/settings/developers"

ROTATION_COMMANDS[GOOGLE_CLIENT_SECRET]="
  # Google OAuth: regenerate in Google Cloud Console
  # https://console.cloud.google.com/apis/credentials"

ROTATION_COMMANDS[SENTRY_AUTH_TOKEN]="
  # Sentry: rotate token at https://sentry.io/settings/auth-tokens/"

ROTATION_COMMANDS[OPENROUTER_API_KEY]="
  # OpenRouter: rotate at https://openrouter.ai/keys"

ROTATION_COMMANDS[CLOUDFLARE_API_TOKEN]="
  # Cloudflare: rotate at https://dash.cloudflare.com/profile/api-tokens
  # Or via CLI:
  # curl -X DELETE https://api.cloudflare.com/client/v4/user/tokens/<TOKEN_ID>"

ROTATION_COMMANDS[MINIMAX_API_KEY]="
  # MiniMax: rotate via MiniMax developer console
  # https://api.minimax.chat/"

echo "Secrets to rotate (from .env.example):"
echo "─────────────────────────────────────────"

while IFS= read -r line; do
  # Skip comments and blank lines
  [[ "$line" =~ ^[[:space:]]*# ]] && continue
  [[ -z "${line// /}" ]] && continue

  key="${line%%=*}"

  if [[ -n "${ROTATION_COMMANDS[$key]+x}" ]]; then
    echo -e "  ${YELLOW}●${NC} $key"
    echo -e "${ROTATION_COMMANDS[$key]}"
    echo ""
  fi
done < "$PROJECT_ROOT/.env.example"

# ──────────────────────────────────────────────
# 3. Git history scrub reminder
# ──────────────────────────────────────────────
echo ""
log "========================================="
log " GIT HISTORY SCRUB"
log "========================================="
echo ""
warn "If any .env files were EVER committed to git history, you MUST scrub them."
warn ""
warn "Option A: BFG Repo-Cleaner (recommended)"
warn "  brew install bfg"
warn "  bfg --delete-files '.env*' --no-blob-protection"
warn "  git reflog expire --expire=now --all"
warn "  git gc --prune=now --aggressive"
warn ""
warn "Option B: git-filter-repo"
warn "  pip install git-filter-repo"
warn "  git filter-repo --invert-paths --path .env --path .env.local --path .env.production"
warn ""
warn "After scrubbing, force-push to all remotes:"
warn "  git push --force --all"
warn "  git push --force --tags"
echo ""
log "Done. Review the rotation commands above and execute each one."
log "After rotating, update .env with new values and restart services."
