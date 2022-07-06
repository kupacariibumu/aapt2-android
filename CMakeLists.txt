cmake_minimum_required(VERSION 3.14.2)
project(build-tools)

# set global cflags and cxxflags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fcolor-diagnostics -fPIC -Wno-attributes -std=gnu11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fcolor-diagnostics -fPIC -Wno-attributes -std=gnu++2a")

# static link
set(CMAKE_EXE_LINKER_FLAGS "-static")

set(SRC_PATH ${PROJECT_SOURCE_DIR}/src)
set(TOOLS_VERSION "31.0.3")

# 64-bit off_t for lseek.
add_definitions(-D_FILE_OFFSET_BITS=64)

if(NOT DEFINED ANDROID_ABI)
    message(FATAL_ERROR "ANDROID_ABI is not defined")
endif()

if(ANDROID_ABI STREQUAL "arm64-v8a" OR ANDROID_ABI STREQUAL "armeabi-v7a")
    enable_language(ASM)
elseif(ANDROID_ABI STREQUAL "x86_64" OR ANDROID_ABI STREQUAL "x86")
    enable_language(ASM_NASM)
else()
    message(FATAL_ERROR "Unsupported architecture: ${ANDROID_ABI}")
endif()

# precompiled libs
add_library(crypto STATIC IMPORTED)
set_target_properties(crypto PROPERTIES IMPORTED_LOCATION ${SRC_PATH}/boringssl/lib/${ANDROID_ABI}/libcrypto.a)
add_library(ssl STATIC IMPORTED)
set_target_properties(ssl PROPERTIES IMPORTED_LOCATION ${SRC_PATH}/boringssl/lib/${ANDROID_ABI}/libssl.a)

# building libs and tools
add_subdirectory(libs)
add_subdirectory(tools)