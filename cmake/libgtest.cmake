add_library(libgtest STATIC ${SRC_PATH}/googletest/src/gtest-all.cc)
    
target_include_directories(libgtest PRIVATE
    ${SRC_PATH}/googletest/include
    ${SRC_PATH}/googletest)