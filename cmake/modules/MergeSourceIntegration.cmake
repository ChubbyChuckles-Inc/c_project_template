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
    # Build a minimal subset needed for windowing/input: Forge (f_*), Imagine (i_*), Betray (b_*).
    # Exclude Relinquish (r_*), Seduce (s_*), Persuade2 (p2_*), HxA (hxa_*), etc. to avoid unrelated compile issues.
    file(GLOB MERGESOURCE_CORE
        ${MERGESOURCE_ROOT}/f_*.c
        ${MERGESOURCE_ROOT}/i_*.c
        ${MERGESOURCE_ROOT}/r_*.c
    )
    # Pick only the Windows Betray sources explicitly
    list(APPEND MERGESOURCE_CORE
        ${MERGESOURCE_ROOT}/b_main.c
        ${MERGESOURCE_ROOT}/b_win32_main.c
        ${MERGESOURCE_ROOT}/b_win32_key_codes.c
    )
    # Exclude problematic or non-Windows sources
    # Filter out problematic or platform-mismatched sources if the glob picked them up
    list(FILTER MERGESOURCE_CORE EXCLUDE REGEX ".*/i_shared_memory\\.c$")
    list(FILTER MERGESOURCE_CORE EXCLUDE REGEX ".*/f_types\\.c$")
    list(FILTER MERGESOURCE_CORE EXCLUDE REGEX ".*/b_x11\\.c$")
    list(FILTER MERGESOURCE_CORE EXCLUDE REGEX ".*/b_android_main\\.c$")
    list(FILTER MERGESOURCE_CORE EXCLUDE REGEX ".*/b_macos_main\\.c$")
    add_library(mergesource STATIC ${MERGESOURCE_CORE})
    target_include_directories(mergesource PUBLIC ${MERGESOURCE_ROOT})
    target_compile_definitions(mergesource PRIVATE FORGE_RELEASE_BUILD)

    # Link platform-specific libraries as needed
    if(WIN32)
        # Windows system libraries needed by MergeSource (windowing, OpenGL, sockets, multimedia, common dialogs, shell)
        target_link_libraries(mergesource PUBLIC user32 gdi32 ws2_32 winmm opengl32 comdlg32 shell32)
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
