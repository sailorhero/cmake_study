include_directories(${PROJECT_SOURCE_DIR}/libhello)

set(APP_SRC main.cpp)

add_executable(hello ${APP_SRC})
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)

#link "libhello" to hello program
target_link_libraries(hello libhello)
