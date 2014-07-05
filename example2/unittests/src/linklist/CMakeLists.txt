#PROJECT(ds)
ADD_EXECUTABLE(linklist_unittest linklist_unittest.cpp)
#将cpp文件编译成可执行程序

TARGET_LINK_LIBRARIES(linklist_unittest gtest gtest_main ds)
#编译成可执行程序时需要链接的库