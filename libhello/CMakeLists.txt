set(LIB_SRC hello.cpp)

#add new target "libhello"
#add_library(libhello ${LIB_SRC})
add_library(libhello SHARED ${LIB_SRC})
set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)

#set lib name to hello.so or libhello.a 
set_target_properties(libhello PROPERTIES OUTPUT_NAME "hello")
