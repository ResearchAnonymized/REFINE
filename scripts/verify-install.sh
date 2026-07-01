#!/bin/bash
# Verify REFINE installation: services, LangGraph orchestration, demo flags.
set -euo pipefail

REFINE="$(cd "$(dirname "$0")/.." && pwd)"

if [ -f "$REFINE/config/ports.env" ]; then
  # shellcheck disable=SC1091
  source "$REFINE/config/ports.env"
fi
FRONTEND_PORT="${FRONTEND_PORT:-3001}"
BACKEND_PORT="${BACKEND_PORT:-8084}"
AGENTS_PORT="${AGENTS_PORT:-8092}"

pass() { echo "  OK: $*"; }
fail() { echo "  FAIL: $*" >&2; exit 1; }

command -v curl >/dev/null || fail "curl required"
command -v jq >/dev/null || fail "jq required"

echo "== REFINE installation check =="
echo

echo "-- Source layout --"
[ -f "$REFINE/agents/refactor_graph.py" ] || fail "missing refactor_graph.py"
[ -f "$REFINE/agents/multi_llm_independent.py" ] || fail "missing multi_llm_independent.py"
[ -f "$REFINE/agents/AGENT_ARCHITECTURE.md" ] || fail "missing AGENT_ARCHITECTURE.md"
pass "LangGraph agent modules present"

echo "-- HTTP health --"
curl -sfS "http://127.0.0.1:${BACKEND_PORT}/api/health" | jq -e '.status != null' >/dev/null \
  || fail "backend not healthy on :${BACKEND_PORT}"
pass "backend :${BACKEND_PORT}"

HEALTH="$(curl -sfS "http://127.0.0.1:${AGENTS_PORT}/agents/health")"
echo "$HEALTH" | jq -e '.status == "ok"' >/dev/null || fail "agents health"
echo "$HEALTH" | jq -e '.orchestrator == "langgraph"' >/dev/null || fail "orchestrator not langgraph"
echo "$HEALTH" | jq -e '.langgraphAvailable == true' >/dev/null || fail "langgraph not available"
pass "agents :${AGENTS_PORT} (graph $(echo "$HEALTH" | jq -r .graphVersion))"

curl -sfS -o /dev/null -w "%{http_code}" "http://127.0.0.1:${FRONTEND_PORT}" | grep -q 200 \
  || fail "frontend not on :${FRONTEND_PORT}"
pass "frontend :${FRONTEND_PORT}"

echo
echo "== Installation check passed =="
