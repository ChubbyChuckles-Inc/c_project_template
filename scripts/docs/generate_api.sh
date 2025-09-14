#!/usr/bin/env bash
set -euo pipefail

if ! command -v doxygen >/dev/null 2>&1; then
	echo "ERROR: doxygen not found. Please install doxygen (and graphviz for diagrams)." >&2
	exit 1
fi

DOXYFILE="docs/Doxyfile"
if [ ! -f "$DOXYFILE" ]; then
	echo "ERROR: $DOXYFILE not found." >&2
	exit 2
fi

pushd docs >/dev/null
doxygen Doxyfile
popd >/dev/null

echo "API documentation generated under docs/api." >&2
