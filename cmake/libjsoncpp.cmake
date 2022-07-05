add_library(libjsoncpp STATIC
    ${SRC_PATH}/jsoncpp/json_reader.cpp
    ${SRC_PATH}/jsoncpp/json_value.cpp
    ${SRC_PATH}/jsoncpp/json_valueiterator.inl
    ${SRC_PATH}/jsoncpp/json_writer.cpp)
    
target_compile_definitions(libjsoncpp PUBLIC
    -DJSON_USE_EXCEPTION=0
    -DJSONCPP_NO_LOCALE_SUPPORT)
    
target_include_directories(libjsoncpp PUBLIC ${SRC_PATH}/jsoncpp/include)