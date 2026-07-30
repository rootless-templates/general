#!/usr/bin/env bash
# Runs on the host as the devcontainer "initializeCommand", i.e. before the
# container is created/started. Docker/Podman's --env-file (see runArgs in
# devcontainer.json) requires the file to already exist at that point, so it
# cannot be created later by postCreateCommand. Idempotent: safe to re-run on
# every container start/rebuild.
set -euo pipefail
cd "$(dirname "$0")/.."

[ -f .env.local ] || cp .env .env.local
[ -f .devcontainer/env.local ] || cp .devcontainer/env .devcontainer/env.local
