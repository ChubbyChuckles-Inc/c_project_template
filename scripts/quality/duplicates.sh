#!/usr/bin/env bash
set -euo pipefail
if command -v jscpd >/dev/null 2>&1; then
	jscpd --languages c --reporters console --min-tokens 50 --ignore "**/build/**,**/00_c_source_files/**" . || true
else
	echo "WARN: jscpd not found; skipping duplication detection" >&2
fi
