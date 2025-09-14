cmake_minimum_required(VERSION 3.20)
add_executable(example_graphics src/main.c src/renderer.c)
target_include_directories(example_graphics PRIVATE ${CMAKE_SOURCE_DIR}/include)
target_link_libraries(example_graphics PRIVATE project_core)
