include_directories(${PROJECT_SOURCE_DIR}/libhello)

set(APP_SRC main.c)

add_executable(hello ${APP_SRC})

#link "libhello" to hello program
target_link_libraries(hello libhello)
