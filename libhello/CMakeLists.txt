set(LIB_SRC hello.c)

#add new target "libhello"
add_library(libhello ${LIB_SRC})

#set lib name to hello.so or libhello.a 
set_target_properties(libhello PROPERTIES OUTPUT_NAME "hello")
