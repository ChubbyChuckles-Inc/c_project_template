#!/usr/bin/env bash
# Placeholder: CMock mock generation script
# Requirements:
#   - Ruby environment with CMock installed (gem install cmock)
#   - YAML config (cmock.yml) defining generation options
# Usage:
#   scripts/test/generate_mocks.sh path/to/header.h out_dir
set -euo pipefail
if ! command -v ruby >/dev/null 2>&1; then
  echo "Ruby is required for CMock; please install Ruby and the CMock gem." >&2
  exit 1
fi
if [ $# -lt 2 ]; then
  echo "Usage: $0 header.h out_dir" >&2
  exit 2
fi
HEADER="$1"
OUTDIR="$2"
mkdir -p "$OUTDIR"
ruby -rcmock -e "
require 'cmock'
cmock = CMock.new('cmock.yml')
cmock.setup_mocks([ENV['HEADER']])
" HEADER="$HEADER"
echo "Mocks generated in $OUTDIR (if configured)."
