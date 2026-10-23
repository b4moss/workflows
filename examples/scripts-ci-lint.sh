#!/usr/bin/env bash
# Convention: each consumer repo provides scripts/ci/lint.sh
set -euo pipefail
if [ -f Makefile ] && grep -q '^lint:' Makefile; then
  make lint
  exit 0
fi
echo "TODO: project-specific lint"
