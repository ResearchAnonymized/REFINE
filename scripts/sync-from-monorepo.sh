#!/bin/bash
# Copy production REFINE slice from monorepo parent (../.. from scripts/ = repo root).
# Re-run after monorepo changes; patches are applied via feature flags in synced code.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REFINE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
MONO_ROOT="$(cd "$REFINE_ROOT/.." && pwd)"

if [ ! -f "$MONO_ROOT/agents/main.py" ]; then
  echo "ERROR: monorepo root not found at $MONO_ROOT"
  exit 1
fi

echo "Syncing REFINE from $MONO_ROOT → $REFINE_ROOT"

RSYNC=(rsync -a --delete)

# --- Agents (pruned) ---
"${RSYNC[@]}" \
  --exclude '__pycache__/' \
  --exclude '.venv/' \
  --exclude 'baseline_comparison/' \
  --exclude 'baseline_router.py' \
  --exclude 'collect_research_data.py' \
  --exclude 'test_baseline_*.py' \
  "$MONO_ROOT/agents/" "$REFINE_ROOT/agents/"

# --- Backend (full; build artifacts excluded) ---
"${RSYNC[@]}" \
  --exclude 'target/' \
  --exclude 'build/' \
  --exclude '.gradle/' \
  "$MONO_ROOT/backend/" "$REFINE_ROOT/backend/"

# --- Web app (full; deps and build excluded) ---
mkdir -p "$REFINE_ROOT/web"
"${RSYNC[@]}" \
  --exclude 'node_modules/' \
  --exclude '.next/' \
  --exclude '.env.local' \
  --exclude 'scripts/export-*research*.ts' \
  --exclude 'scripts/export-paper*.ts' \
  --exclude 'scripts/validate-icse*.ts' \
  --exclude 'scripts/prepare-research*.ts' \
  --exclude 'scripts/verify-extended-research*.ts' \
  --exclude 'scripts/write-research*.ts' \
  --exclude 'scripts/export-rq*.ts' \
  "$MONO_ROOT/web/app/" "$REFINE_ROOT/web/app/"

# --- PMD rules ---
"${RSYNC[@]}" "$MONO_ROOT/rulesets/" "$REFINE_ROOT/rulesets/"

# --- Gradle root (for optional full Gradle builds) ---
for f in settings.gradle build.gradle gradlew gradlew.bat; do
  [ -f "$MONO_ROOT/$f" ] && cp "$MONO_ROOT/$f" "$REFINE_ROOT/$f"
done
[ -d "$MONO_ROOT/gradle" ] && "${RSYNC[@]}" "$MONO_ROOT/gradle/" "$REFINE_ROOT/gradle/"

# --- Shared scripts ---
mkdir -p "$REFINE_ROOT/scripts"
for f in detach_daemon.py e2e-refactai-smoke.sh; do
  [ -f "$MONO_ROOT/scripts/$f" ] && cp "$MONO_ROOT/scripts/$f" "$REFINE_ROOT/scripts/$f"
done

# --- Config template (example only; user copies to ports.env) ---
mkdir -p "$REFINE_ROOT/config"
[ -f "$REFINE_ROOT/config/ports.env.example" ] || cp "$MONO_ROOT/REFINE/config/ports.env.example" "$REFINE_ROOT/config/ports.env.example" 2>/dev/null || true

echo "Done. Next: cp REFINE/config/ports.env.example REFINE/config/ports.env && ./REFINE/scripts/start-refine.sh"
