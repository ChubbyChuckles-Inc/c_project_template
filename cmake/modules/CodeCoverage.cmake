include_guard()

function(enable_coverage_for_target target)
    if(ENABLE_COVERAGE AND (CMAKE_C_COMPILER_ID MATCHES "Clang|GNU"))
        target_compile_options(${target} PRIVATE --coverage -fprofile-arcs -ftest-coverage)
        target_link_libraries(${target} PRIVATE gcov)
    endif()
endfunction()
