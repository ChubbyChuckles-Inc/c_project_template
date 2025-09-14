cmake_minimum_required(VERSION 3.20)

add_executable(example_hello src/main.c)
target_link_libraries(example_hello PRIVATE project_core)
