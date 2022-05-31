add_library(libfmt STATIC ${SRC_PATH}/fmtlib/src/format.cc)
    
target_include_directories(libfmt PRIVATE ${SRC_PATH}/fmtlib/include)