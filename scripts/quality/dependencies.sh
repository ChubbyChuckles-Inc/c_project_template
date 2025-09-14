#!/usr/bin/env bash
set -euo pipefail
if command -v include-what-you-use >/dev/null 2>&1; then
	FILES=$(git ls-files "*.c" || true)
	if [ -n "$FILES" ]; then
		include-what-you-use $FILES | tee quality_includes.txt || true
		echo "Include analysis: quality_includes.txt" >&2
	fi
else
	echo "WARN: include-what-you-use not found; skipping include analysis" >&2
fi
