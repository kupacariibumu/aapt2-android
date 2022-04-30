add_library(libincfs STATIC
    ${SRC_PATH}/incremental_delivery/incfs/incfs_ndk.c
    ${SRC_PATH}/incremental_delivery/incfs/incfs.cpp
    ${SRC_PATH}/incremental_delivery/incfs/MountRegistry.cpp
    ${SRC_PATH}/incremental_delivery/incfs/path.cpp
    ${SRC_PATH}/incremental_delivery/incfs/util/map_ptr.cpp
    ${SRC_PATH}/incremental_delivery/sysprop/IncrementalProperties.sysprop.cpp
    )
    
target_include_directories(libincfs PUBLIC
    ${SRC_PATH}/incremental_delivery/incfs/include 
    ${SRC_PATH}/incremental_delivery/incfs/util/include 
    ${SRC_PATH}/incremental_delivery/sysprop/include
    ${SRC_PATH}/incremental_delivery/incfs/kernel-headers
    ${SRC_PATH}/libbase/include
    ${SRC_PATH}/libutils/include
    ${SRC_PATH}/boringssl/include
    ${SRC_PATH}/libselinux/include
    ${SRC_PATH}/liblog/include 
    )
