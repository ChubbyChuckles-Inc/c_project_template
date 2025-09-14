# Minimal Android toolchain forwarding to Android NDK cmake toolchain
if(NOT DEFINED ANDROID_NDK)
    message(FATAL_ERROR "ANDROID_NDK path must be provided (e.g., -DANDROID_NDK=$ENV{ANDROID_NDK_HOME})")
endif()

set(CMAKE_TOOLCHAIN_FILE "${ANDROID_NDK}/build/cmake/android.toolchain.cmake" CACHE FILEPATH "Android NDK toolchain" FORCE)
