#include_directories(${PROJECT_SOURCE_DIR}/libhello)

# Locate GTest
find_package(GTest REQUIRED)
include_directories("/usr/include" ${GTEST_INCLUDE_DIRS} ${PROJECT_SOURCE_DIR}/libhello)

set(TEST_SRC hellotest.cpp)

add_executable(helloTest ${TEST_SRC})
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)

#link "libhello" to hello program
target_link_libraries(helloTest libhello ${GTEST_LIBRARIES} pthread)
