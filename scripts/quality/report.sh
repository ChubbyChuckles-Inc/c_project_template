#!/usr/bin/env bash
set -euo pipefail
echo "Aggregating quality reports..." >&2
./scripts/quality/complexity.sh || true
./scripts/quality/metrics.sh || true
./scripts/quality/dependencies.sh || true
./scripts/quality/duplicates.sh || true
./scripts/quality/security.sh || true
./scripts/quality/performance.sh || true
echo "Done. Check generated quality_* files or console outputs for details." >&2
