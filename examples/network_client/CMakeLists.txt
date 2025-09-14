cmake_minimum_required(VERSION 3.20)
add_executable(example_network src/main.c src/client.c)
target_include_directories(example_network PRIVATE ${CMAKE_SOURCE_DIR}/include)
target_link_libraries(example_network PRIVATE project_core)
