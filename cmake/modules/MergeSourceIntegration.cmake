include_guard()

# MergeSource root
set(MERGESOURCE_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/00_c_source_files CACHE PATH "Path to MergeSource sources")

file(GLOB MERGESOURCE_HEADERS
    ${MERGESOURCE_ROOT}/*.h
)

# Select a minimal set to satisfy platform abstractions; keep as INTERFACE to avoid compiling everything.
add_library(mergesource_interface INTERFACE)
target_include_directories(mergesource_interface INTERFACE ${MERGESOURCE_ROOT})

# If building MergeSource sources is desired (optional)
if(ENABLE_MERGESOURCE_BUILD)
    file(GLOB MERGESOURCE_CORE
        ${MERGESOURCE_ROOT}/f_*.c
        ${MERGESOURCE_ROOT}/i_*.c
        ${MERGESOURCE_ROOT}/t_*.c
        ${MERGESOURCE_ROOT}/r_*.c
        ${MERGESOURCE_ROOT}/v_*.c
        ${MERGESOURCE_ROOT}/hxa_*.c
        ${MERGESOURCE_ROOT}/p2_*.c
        ${MERGESOURCE_ROOT}/s_*.c
        ${MERGESOURCE_ROOT}/b_*.c
        ${MERGESOURCE_ROOT}/observatory_*.c
        ${MERGESOURCE_ROOT}/assemble_json.c
        ${MERGESOURCE_ROOT}/hxa_convesion_generated.c
    )
    add_library(mergesource STATIC ${MERGESOURCE_CORE})
    target_include_directories(mergesource PUBLIC ${MERGESOURCE_ROOT})
    target_compile_definitions(mergesource PRIVATE FORGE_RELEASE_BUILD)

    # Link platform-specific libraries as needed
    if(WIN32)
        target_link_libraries(mergesource PUBLIC user32 gdi32 ws2_32 winmm)
    elseif(APPLE)
        find_library(COCOA_FRAMEWORK Cocoa)
        find_library(OPENGL_FRAMEWORK OpenGL)
        target_link_libraries(mergesource PUBLIC ${COCOA_FRAMEWORK} ${OPENGL_FRAMEWORK})
    elseif(ANDROID)
        target_link_libraries(mergesource PUBLIC log android EGL GLESv2)
    elseif(UNIX)
        find_package(OpenGL REQUIRED)
        find_package(X11 REQUIRED)
        target_link_libraries(mergesource PUBLIC ${OPENGL_LIBRARIES} X11 m pthread)
    endif()

    # If built, link interface to impl
    target_link_libraries(mergesource_interface INTERFACE mergesource)
endif()
