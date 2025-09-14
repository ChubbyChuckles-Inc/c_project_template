#!/usr/bin/env bash
set -euo pipefail
git ls-files "*.c" "*.h" | xargs -I{} clang-format -i {}
