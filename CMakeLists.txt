cmake_minimum_required(VERSION 3.20)

project(c11_multiplatform_template
    VERSION 1.0.0
    LANGUAGES C
    DESCRIPTION "C11 Multiplatform Template with MergeSource"
)

# Enforce C11
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

option(BUILD_TESTS "Build unit tests" ON)
option(BUILD_EXAMPLES "Build examples" ON)
option(ENABLE_COVERAGE "Enable code coverage (GCC/Clang)" OFF)
option(ENABLE_STATIC_ANALYSIS "Enable static analysis tools" ON)
option(ENABLE_MERGESOURCE_BUILD "Build MergeSource sources (experimental)" OFF)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules")

include(PlatformDetection)
include(CompilerFlags)
include(MergeSourceIntegration)

# Public include directory
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

# Core library
add_library(project_core STATIC
    src/main.c
)
target_link_libraries(project_core PRIVATE mergesource_interface)
target_include_directories(project_core PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)

if(ENABLE_COVERAGE)
    include(CodeCoverage)
    enable_coverage_for_target(project_core)
endif()

# Executable (example app)
add_executable(project_app src/main.c)
target_link_libraries(project_app PRIVATE project_core)

# Tests
if(BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()

# Examples
if(BUILD_EXAMPLES)
    add_subdirectory(examples/hello_world)
    add_subdirectory(examples/graphics_demo)
    add_subdirectory(examples/network_client)
endif()

# Install rules (basic)
install(TARGETS project_core project_app
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)
install(DIRECTORY include/ DESTINATION include)
