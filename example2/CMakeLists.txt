PROJECT(ds)
#工程名

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
#最低版本号

INCLUDE_DIRECTORIES(
  ${PROJECT_SOURCE_DIR}/include
  ${PROJECT_SOURCE_DIR}/include/linklist
  
  /usr/local/include
  /usr/include
)
#头文件目录

LINK_DIRECTORIES(
  ${PROJECT_SOURCE_DIR}/lib

  /usr/local/lib
  /usr/lib
)
#链接库目录

SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)
#生成的可执行文件所在目录，PROJECT_BINARY_DIR即为外部编译目录，这里即为Build目录

SET(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)
#生成的库文件所在目录

ADD_SUBDIRECTORY(src)
ADD_SUBDIRECTORY(tests)
ADD_SUBDIRECTORY(unittests)
#添加三个要编译的子文件夹

###########################################################
# Unit Tests
# 顶层CMakelists.txt定义单元测试，否则make test目标不生成。
###########################################################
enable_testing()
# Add unittest 
add_test(NAME linklist_unittest COMMAND linklist_unittest )