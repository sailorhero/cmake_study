# 项目持续集成工具和配置

## 工具列表

1. CCCC
2. CPPNCSS
    
	2个关键指标含义
	- NCSS（Non Commenting Source Statements）有效代码行，扣除注释。
	- CCN（Cyclomatic Complexity Number），圈复杂度。1个方法的CCN值通常意味着我们需要多少个案例来覆盖其不同的路径。当CCN发生很大波动或者CCN很高的代码片段被变更时，意味改动引入缺陷风险高。根据资料，圈复杂度（或CC）大于10的方法存在很大的出错风险。
3. CPPCHECK - static code analysis for common errors in C++
4. SLOCCOUNT- lines of code counting
5. GCOV和GCOVR
	- Gcov is GCC Coverage
	- 是一个测试代码覆盖率的工具
	- 是一个命令行方式的控制台程序
	- 伴随GCC发布，配合GCC共同实现对C/C++文件的语句覆盖和分支覆盖测试；
	- 与程序概要分析工具(profiling tool，例如gprof)一起工作，可以估计程序中哪一段代码最耗时；
	- 注：程序概要分析工具是分析代码性能的工具。
	
6. Googletest 单元测试框架

## CCCC
    $ sudo apt-get install CCCC

## CPPNCSS
    运行在Java环境下，需要设置JAVA_HOME及JAVA运行环境
    下载安装
    http://cppncss.sourceforge.net/index.html
    将cppncss-X.X.X.tar.gz解压.     
    运行
    修改环境变量 export PATH=$PATH:/path/cppncss-X.X.X/bin
## CPPCHECK
    $ sudo apt-get install cppcheck

## SLOCCOUNT
    $ sudo apt-get install sloccount

## GCOV和GCOVR，及LCOV
  
    \#安装Setuptools and EasyInstall

    `wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python`
    
    \#安装gcovr
 
    `sudo easy_install gcovr`

    \#安装lcov

    `sudo apt-get  install lcov`

参考文档：

1. [[整理] gcov lcov 覆盖c/c++项目入门](http://www.cnblogs.com/turtle-fly/archive/2013/01/09/2851474.html)
2. [Jenkins中集成Gcov代码覆盖率报告](http://www.cnblogs.com/jackyim/p/3772306.html)

## googletest

1. 下载[gtest源码](http://code.google.com/p/googletest/downloads/list)，最新版本1.7.0
2. 编译，生成gtest库
3. 使用方法：
    1. 手工安装，头文件安装到/usr/include/gtest中，库文件(libgtest.a,libgtest_main.a)安装到/usr/local/lib
    
    2. 设置${GTEST_DIR}指向，gtest目录。具体参见gtest源码中的README。 
    3. 将googletest源码解压作为项目的一个子目录，工程对应的顶级CMakelists.txt内容如下：
    
    cmake_minimum_required(VERSION 2.6)
    project(basic_test)
    
    ################################
    # GTest
    ################################
    ADD_SUBDIRECTORY (gtest-1.6.0)
    enable_testing()
    include_directories(${gtest_SOURCE_DIR}/include ${gtest_SOURCE_DIR})
    
    ################################
    # Unit Tests
    ################################
    # Add test cpp file
    add_executable( runUnitTests testgtest.cpp )
    # Link test executable against gtest & gtest_main
    target_link_libraries(runUnitTests gtest gtest_main)
    add_test( runUnitTests runUnitTests ) 

参考文档：

1. [googletest主页](http://code.google.com/p/googletest/)
1. [Getting started with Google Test (GTest) on Ubuntu](http://www.cnblogs.com/PursuitOnly/archive/2013/01/07/2849662.html)
2. [玩转Google开源C++单元测试框架Google Test系列(gtest)(总)](http://www.cnblogs.com/coderzh/archive/2009/04/06/1426755.html)

## googlemock

参考文档：

1. [googlemock主页](http://code.google.com/p/googlemock/)