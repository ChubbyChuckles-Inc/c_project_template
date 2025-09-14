#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <project_name>" >&2
  exit 1
fi
NAME="$1"
mkdir -p "examples/$NAME/src"
cat > "examples/$NAME/CMakeLists.txt" <<EOF
cmake_minimum_required(VERSION 3.20)
add_executable(example_${NAME} src/main.c)
target_link_libraries(example_${NAME} PRIVATE project_core)
EOF
cat > "examples/$NAME/src/main.c" <<EOF
#include "../../../include/project_api.h"
#include <stdio.h>
int main(void){ if(project_init()!=0){return 1;} printf("${NAME} example\n"); project_shutdown(); return 0; }
EOF
echo "Created example project: examples/$NAME"
