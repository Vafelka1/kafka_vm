#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

if [[ -f .env ]]; then
  ENV_FLAG=(--env-file .env)
else
  echo "[kafka] .env not found, using defaults or env of current shell"
  ENV_FLAG=()
fi

echo "[kafka] Starting containers..."
docker compose "${ENV_FLAG[@]}" up -d

echo "[kafka] Containers status:"
docker compose ps


