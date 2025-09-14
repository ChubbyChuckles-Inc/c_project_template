#!/usr/bin/env bash
set -euo pipefail

if ! command -v cmake >/dev/null 2>&1; then echo "ERROR: cmake not found" >&2; exit 1; fi
if ! command -v clang-tidy >/dev/null 2>&1; then echo "WARN: clang-tidy not found; skipping" >&2; SKIP_TIDY=1; else SKIP_TIDY=0; fi
if ! command -v cppcheck >/dev/null 2>&1; then echo "WARN: cppcheck not found; skipping" >&2; SKIP_CPPCHECK=1; else SKIP_CPPCHECK=0; fi

cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug || true
if [ "$SKIP_TIDY" -eq 0 ]; then
	FILES=$(git ls-files "*.c" || true)
	if [ -n "$FILES" ]; then clang-tidy $FILES -p build || true; fi
fi
if [ "$SKIP_CPPCHECK" -eq 0 ]; then
	cppcheck --enable=all --inconclusive --error-exitcode=1 --force --inline-suppr . || true
fi
