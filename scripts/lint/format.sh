#!/usr/bin/env bash
set -euo pipefail

if ! command -v clang-format >/dev/null 2>&1; then
	echo "ERROR: clang-format not found" >&2
	exit 1
fi

FILES=$(git ls-files "*.c" "*.h" || true)
if [ -n "$FILES" ]; then
	echo "$FILES" | xargs -I{} clang-format -i {}
fi
