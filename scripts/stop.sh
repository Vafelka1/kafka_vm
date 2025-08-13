#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

ENV_FLAG=()
[[ -f .env ]] && ENV_FLAG=(--env-file .env)

if [[ "${1:-}" == "-v" || "${1:-}" == "--volumes" ]]; then
  docker compose "${ENV_FLAG[@]}" down -v
else
  docker compose "${ENV_FLAG[@]}" down
fi

echo "[kafka] Stopped."


