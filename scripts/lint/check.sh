#!/usr/bin/env bash
set -euo pipefail
./scripts/lint/format.sh
./scripts/lint/analyze.sh
