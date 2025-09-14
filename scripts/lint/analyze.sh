#!/usr/bin/env bash
set -euo pipefail
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug || true
clang-tidy $(git ls-files "*.c") -p build || true
cppcheck --enable=all --inconclusive --error-exitcode=1 --force --inline-suppr .
