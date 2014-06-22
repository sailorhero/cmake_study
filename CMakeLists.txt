project(HELLO)

cmake_minimum_required(VERSION 2.8)

# 设置版本号.
set(HELLO_VERSION_MAJOR 1)
set(HELLO_VERSION_MINOR 0)

add_subdirectory(src)
add_subdirectory(libhello)
add_subdirectory(test)
