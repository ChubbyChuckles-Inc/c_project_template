#!/usr/bin/env bash
set -euo pipefail
mkdir -p coverage
lcov --capture --directory build --output-file coverage/coverage.info || true
genhtml coverage/coverage.info --output-directory coverage/html || true
