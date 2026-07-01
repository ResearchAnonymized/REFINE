#!/bin/bash
# Start REFINE production stack. Safe to run from any directory.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
exec "$ROOT/REFINE/scripts/start-refine.sh" "$@"
