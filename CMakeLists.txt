project(HELLO)
set(APP_SRC main.c)
set(LIB_SRC hello.c)
#add new target "libhello"
add_library(libhello ${LIB_SRC})
add_executable(hello ${APP_SRC})

#link "libhello" to hello program
target_link_libraries(hello libhello)
