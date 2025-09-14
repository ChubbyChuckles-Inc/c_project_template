#!/usr/bin/env bash
set -euo pipefail
if ! command -v ctest >/dev/null 2>&1; then
	echo "ERROR: ctest not found (install CMake)" >&2
	exit 1
fi
ctest --test-dir build --output-on-failure
