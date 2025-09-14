#!/usr/bin/env bash
set -euo pipefail
mkdir -p coverage
if ! command -v lcov >/dev/null 2>&1; then
	echo "WARN: lcov not found; skipping Linux/macOS coverage capture" >&2
else
	lcov --capture --directory build --output-file coverage/coverage.info || true
	if command -v genhtml >/dev/null 2>&1; then
		genhtml coverage/coverage.info --output-directory coverage/html || true
	else
		echo "WARN: genhtml not found; HTML report not generated" >&2
	fi
fi
