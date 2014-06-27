set(LIB_SRC hello.cpp)

#add new target "libhello"
#add_library(libhello ${LIB_SRC})
add_library(libhello SHARED ${LIB_SRC})
set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)

#set lib name to hello.so or libhello.a 
set_target_properties(libhello PROPERTIES OUTPUT_NAME "hello")


# 设置库版本号：VERSION 指代动态库版本,SOVERSION 指代 API 版本
set(HELLOLIB_VERSION_MAJOR 1)
set(HELLOLIB_VERSION_MINOR 0)
set(HELLOLIB_SOVERSION 1)

set_target_properties(libhello PROPERTIES VERSION ${HELLOLIB_VERSION_MAJOR}.${HELLOLIB_VERSION_MINOR} SOVERSION ${HELLOLIB_SOVERSION})
