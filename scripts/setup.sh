#!/bin/bash
# First-time REFINE setup: env templates, Python deps, frontend deps, backend JAR.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "== REFINE setup =="
echo

if [ ! -f "$ROOT/config/ports.env" ] && [ -f "$ROOT/config/ports.env.example" ]; then
  cp "$ROOT/config/ports.env.example" "$ROOT/config/ports.env"
  echo "Created config/ports.env from example"
fi

if [ ! -f "$ROOT/agents/.env" ] && [ -f "$ROOT/agents/.env.example" ]; then
  cp "$ROOT/agents/.env.example" "$ROOT/agents/.env"
  echo "Created agents/.env from example — set OPENROUTER_API_KEY before LLM refactoring"
fi

echo "-- Python (agents) --"
python3 -m pip install --upgrade pip >/dev/null
python3 -m pip install -r "$ROOT/agents/requirements.txt"
echo "  OK: agents requirements installed"

echo "-- Node (web) --"
if command -v npm >/dev/null; then
  (cd "$ROOT/web/app" && npm ci)
  echo "  OK: frontend dependencies installed"
else
  echo "  WARN: npm not found — install Node 18+ and re-run"
fi

echo "-- Java (backend) --"
if command -v mvn >/dev/null; then
  (cd "$ROOT/backend/server" && mvn -q -DskipTests package)
  echo "  OK: backend JAR built"
else
  echo "  WARN: mvn not found — install Maven and re-run"
fi

echo
echo "Setup complete. Next:"
echo "  1. Edit agents/.env and set OPENROUTER_API_KEY"
echo "  2. ./start-refine.sh"
echo "  3. Open http://127.0.0.1:3001"
