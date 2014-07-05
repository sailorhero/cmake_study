ADD_EXECUTABLE(linklist_test linklist_test.cpp)
TARGET_LINK_LIBRARIES(linklist_test ds)

SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin/tests)