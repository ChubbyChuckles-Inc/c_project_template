#!/usr/bin/env bash
set -euo pipefail
if command -v cloc >/dev/null 2>&1; then
	cloc --by-file --include-lang=C --exclude-dir=build,docs,examples,00_c_source_files . | tee quality_metrics.txt
	echo "Metrics report: quality_metrics.txt" >&2
else
	echo "WARN: cloc not found; skipping metrics collection" >&2
fi
