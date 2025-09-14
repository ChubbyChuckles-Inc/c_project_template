#!/usr/bin/env bash
set -euo pipefail
if command -v lizard >/dev/null 2>&1; then
	lizard -l c -x 00_c_source_files/ -x build/ . | tee quality_complexity.txt
	echo "Complexity report: quality_complexity.txt" >&2
else
	echo "WARN: lizard not found; skipping complexity analysis" >&2
fi
