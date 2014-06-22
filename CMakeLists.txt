project(HELLO)

cmake_minimum_required(VERSION 2.8)

# 设置版本号.
set(HELLO_VERSION_MAJOR 1)
set(HELLO_VERSION_MINOR 0)

add_subdirectory(src)
add_subdirectory(libhello)
add_subdirectory(test)

# 配置头文件，把CMake设置传递给源文件
configure_file (
  "${PROJECT_SOURCE_DIR}/src/helloconfig.h.in"
  "${PROJECT_BINARY_DIR}/include/helloconfig.h"
)

