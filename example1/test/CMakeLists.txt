include_directories(${PROJECT_SOURCE_DIR}/libhello)

#查找线程库
find_package (Threads)

################################
# Unit Tests Target
################################
# Add test cpp file
add_executable( helloTest hellotest.cpp )
# Link test executable against gtest & gtest_main
target_link_libraries(helloTest gtest gtest_main libhello ${CMAKE_THREAD_LIBS_INIT})

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/test_bin)
