cmake_minimum_required(VERSION 3.20)

# Unity framework (vendor-free embedding)
set(UNITY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/unity)
set(UNITY_SOURCES ${UNITY_DIR}/unity.c)
set(UNITY_HEADERS ${UNITY_DIR}/unity.h ${UNITY_DIR}/unity_internals.h)

add_library(unity STATIC ${UNITY_SOURCES})
target_include_directories(unity PUBLIC ${UNITY_DIR})

# Common test helpers
add_library(test_helpers STATIC helpers/assertion_extensions.c helpers/deterministic_random.c helpers/mock_generators.c)
target_include_directories(test_helpers PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/helpers ${CMAKE_SOURCE_DIR}/include)

function(add_unity_test TEST_NAME TEST_SOURCE)
    add_executable(${TEST_NAME} ${TEST_SOURCE})
    target_link_libraries(${TEST_NAME} PRIVATE unity test_helpers project_core)
    add_test(NAME ${TEST_NAME} COMMAND ${TEST_NAME})
    if(ENABLE_COVERAGE)
        include(${CMAKE_SOURCE_DIR}/cmake/modules/CodeCoverage.cmake)
        enable_coverage_for_target(${TEST_NAME})
    endif()
endfunction()

# Example test (core)
add_unity_test(test_project_init core/memory/test_memory_smoke.c)
