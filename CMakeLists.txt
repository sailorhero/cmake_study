project(hello)

cmake_minimum_required(VERSION 2.8)

# 设置版本号.
set(HELLO_VERSION_MAJOR 1)
set(HELLO_VERSION_MINOR 0)

add_subdirectory(libhello)
add_subdirectory(src)
add_subdirectory(test)

# 配置头文件，把CMake设置传递给源文件
configure_file (
  "${PROJECT_SOURCE_DIR}/include/helloconfig.h.in"
  "${PROJECT_BINARY_DIR}/include/helloconfig.h"
)

################################################################
#CMake选项支持gcov和gprof
################################################################
OPTION(ENABLE_GCOV "Enable gcov (debug, Linux builds only)" OFF)
IF (ENABLE_GCOV AND NOT WIN32 AND NOT APPLE)
  SET(CMAKE_CXX_FLAGS_DEBUG
    "${CMAKE_CXX_FLAGS_DEBUG} -fprofile-arcs -ftest-coverage")
   message("CMAKE_CXX_FLAGS_DEBUG:${CMAKE_CXX_FLAGS_DEBUG}")
  SET(CMAKE_C_FLAGS_DEBUG
    "${CMAKE_C_FLAGS_DEBUG} -fprofile-arcs -ftest-coverage")
  message("CMAKE_C_FLAGS_DEBUG:${CMAKE_C_FLAGS_DEBUG}")
  SET(CMAKE_EXE_LINKER_FLAGS_DEBUG
    "${CMAKE_EXE_LINKER_FLAGS_DEBUG} -fprofile-arcs -ftest-coverage -lgcov")
    message("CMAKE_EXE_LINKER_FLAGS_DEBUG:${CMAKE_EXE_LINKER_FLAGS_DEBUG}")
ENDIF()

OPTION(ENABLE_GPROF "Enable gprof (optimized, Linux builds only)" OFF)
IF (ENABLE_GPROF AND NOT WIN32 AND NOT APPLE)
  SET(CMAKE_C_FLAGS_RELWITHDEBINFO
    "${CMAKE_C_FLAGS_RELWITHDEBINFO} -pg")
  SET(CMAKE_CXX_FLAGS_RELWITHDEBINFO
    "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} -pg")
  SET(CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO
    "${CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO} -pg")
ENDIF()
#############################################################


###########################################################
# GTest 工程定义
###########################################################
ADD_SUBDIRECTORY (gtest-1.7.0)
include_directories(${gtest_SOURCE_DIR}/include ${gtest_SOURCE_DIR})

###########################################################
# Unit Tests
# 顶层CMakelists.txt定义单元测试，否则make test目标不生成。
###########################################################
enable_testing()
# Add unittest 
add_test(NAME helloTest COMMAND helloTest )

###########################################################
# 安装脚本
###########################################################
SET (CMAKE_INSTALL_PREFIX "/tmp/${PROJECT_NAME}") # 设定当前文件夹为安装文件夹
install (FILES "${PROJECT_BINARY_DIR}/include/helloconfig.h"        
         DESTINATION include)
install (PROGRAMS "${PROJECT_SOURCE_DIR}/runhello.sh"        
         DESTINATION bin)
