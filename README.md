# CMake学习

## Mastering CMake



### 小经验

1. 获取命令帮助

	cmake --help-commands

	这个命令将给出所有cmake内置的命令的详细帮助，一般不知道自己要找什么或者想随机翻翻得时候，可以用这个。

	另外也可以用如下的办法层层缩小搜索范围：

	cmake --help-commands-list

	cmake --help-commands-list|grep find

2. 查询变量

	cmake --help-variable-list  | grep CMAKE | grep HOST

	这里查找所有CMake自己定义的builtin变量；一般和系统平台相关。

	如果希望将所有生成的可执行文件、库放在同一的目录下，可以如此做：

	\# Targets directory

	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${target_dir}/lib)

	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${target_dir}/lib)

	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${target_dir}/bin)

	这里的target_dir是一个实现设置好的绝对路径。（CMake里边绝对路径比相对路径更少出问题，如果可能尽量用绝对路径）

3. 属性查询

	cmake --help-property-list | grep NAME

	Property一般很少需要直接改动，除非你想修改一些默认的行为，譬如修改生成的动态库文件的soname等。

	cmake --help-property OUTPUT_NAME

4. CMake模组

	用于查找常用的模块，譬如boost，bzip2, python等。通过简单的include命令包含预定义的模块，就可以得到一些模块执行后定义好的变量，非常方便。

	\# Find boost 1.40
	
	INCLUDE(FindBoost)
	
	find_package(Boost 1.40.0 COMPONENTS thread unit_test_framework)
	
	if(NOT Boost_FOUND)
	
	   message(STATUS "BOOST not found, test will not succeed!")
	
	endif()

	一般开头部分的解释都相当有用，可满足80%需求：

	`cmake --help-module FindBoost | head -40`

5. 如何根据其生成的中间文件查看一些关键信息

	CMake相比较于autotools的一个优势就在于其生成的中间文件组织的很有序，并且清晰易懂，不像autotools会生成天书一样的庞然大物（10000+的不鲜见）。
	
	一般CMake对应的Makefile都是有层级结构的，并且会根据你的CMakeLists.txt间的相对结构在binary directory里边生成相应的目录结构。
	
	譬如对于某一个target，一般binary tree下可以找到一个文件夹:  CMakeFiles/<targentName>.dir/,比如：
	
	skyscribe@skyscribe:~/program/ltesim/bld/dev/simcluster/CMakeFiles/SIMCLUSTER.dir$ ls -l

	total 84

	-rw-r--r-- 1 skyscribe skyscribe 52533 2009-12-12 12:20 build.make

	-rw-r--r-- 1 skyscribe skyscribe  1190 2009-12-12 12:20 cmake_clean.cmake

	-rw-r--r-- 1 skyscribe skyscribe  4519 2009-12-12 12:20 DependInfo.cmake

	-rw-r--r-- 1 skyscribe skyscribe    94 2009-12-12 12:20 depend.make

	-rw-r--r-- 1 skyscribe skyscribe   573 2009-12-12 12:20 flags.make

	-rw-r--r-- 1 skyscribe skyscribe  1310 2009-12-12 12:20 link.txt

	-rw-r--r-- 1 skyscribe skyscribe   406 2009-12-12 12:20 progress.make

	drwxr-xr-x 2 skyscribe skyscribe  4096 2009-12-12 12:20 src

	这里，每一个文件都是个很短小的文本文件，内容相当清晰明了。build.make一般包含中间生成文件的依赖规则，DependInfo.cmake一般包含源代码文件自身的依赖规则。

	比较重要的是flags.make和link.txt，前者一般包含了类似于GCC的-I的相关信息，如搜索路径，宏定义等；后者则包含了最终生成target时候的linkage信息，库搜索路径等。
	这些信息在出现问题的时候是个很好的辅助调试手段。

6. 文件查找、路径相关
	
	include_directories（）用于添加头文件的包含搜索路径

	cmake --help-command include_directories
	
	link_directories()用于添加查找库文件的搜索路径

	cmake --help-command link_directories

7. 库查找

	一般外部库的link方式可以通过两种方法来做，一种是显示添加路径，采用link_directories()， 一种是通过find_library()去查找对应的库的绝对路径。后一种方法是更好的，因为它可以减少不少潜在的冲突。

	一般find_library会根据一些默认规则来搜索文件，如果找到，将会set传入的第一个变量参数、否则，对应的参数不被定义，并且有一个xxx-NOTFOUND被定义；可以通过这种方式来调试库搜索是否成功。

    对于库文件的名字而言，动态库搜索的时候会自动搜索libxxx.so (xxx.dll),静态库则是libxxx.a（xxx.lib），对于动态库和静态库混用的情况，可能会出现一些混乱，需要格外小心；一般尽量做匹配连接。

8. rpath

	所谓的rpath是和动态库的加载运行相关的。我一般采用如下的方式取代默认添加的rpath：

	\# RPATH and library search setting

	SET(CMAKE_SKIP_BUILD_RPATH  FALSE)

	SET(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE) 

	SET(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/nesim/lib")

	SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE) 

9. Utility modules

    CMakePrintSystemInformation     #打印Cmake设置

    message("#####print system information##########")
    include(CMakePrintSystemInformation)
    message("######################################")



### FAQ

1. CMake内调用环境变量

    通过`$ENV{VAR}`访问环境变量；
    
    通过`[HKEY_CURRENT_USER\\Software\\path1\\path2;key]`访问Windows注册表；

2. 指定编译器

    CMake通过制定模组检查编译器
    Modules/CMakeDeterminCCompiler.cmake
    Modules/CMakeDeterminCXXCompiler.cmake
    
    
    可以设置环境变量指定编译器，如：$ENV{CC}/$ENV{CXX}
    
    或者使用CMake命令行变量指定，语法：`-DCACHE_VAR:TYPE=VALUE`    
    例子：
	`cmake -DCMAKE_CXX_COMPILER=xlc -DBUILD_TESTING:BOOL=ON ../foo`
	

3. 指定编译标志

	设置编译环境变量
	
	LDFLAGS= XXX  #设置link标志

	CXXFLAGS= XXX #初始化CMAKE_CXX_FLAGS

	CFLAGS= XXX   #初始化CMAKE_C_FLAGS

4. CMake的依赖分析
	
	依赖分析，使用四个文件depend.make,flags.make,build.make,DependInfo.cmake.depend.make

5. 生成目标

	\#生成可执行文件

	add_executable()

	\#生成库文件，不指定类型，默认生成静态库

	add_library(foo [STATIC|SHARED|MODULE]foo1.c foo2.c)

6. 怎样获得一个目录下的所有源文件
> `aux_source_directory(<dir> <variable>)`

> 将dir中所有源文件（不包括头文件）保存到变量variable中，然后可以`add_executable (ss7gw ${variable})`这样使用。

7. 怎样指定项目编译目标
>  project命令指定

8. 怎样添加动态库和静态库
> `target_link_libraries`命令添加即可

9. 怎样在执行CMAKE时打印消息
> `message([SEND_ERROR | STATUS | FATAL_ERROR] "message to display" ...)`

> 注意大小写

10. 怎样指定头文件与库文件路径
> `include_directories与link_directories`

>可以多次调用以设置多个路径

> `link_directories`仅对其后面的targets起作用

11. 怎样区分debug、release版本
>建立debug/release两目录，分别在其中执行`cmake -DCMAKE_BUILD_TYPE=Debug`（或Release），需要编译不同版本时进入不同目录执行make即可；

>Debug版会使用参数-g；Release版使用-O3 –DNDEBUG

>另一种设置方法——例如DEBUG版设置编译参数DDEBUG

>IF(DEBUG_mode)

>    add_definitions(-DDEBUG)

>ENDIF()

>在执行cmake时增加参数即可，例如`cmake -D DEBUG_mode=ON`

12. 怎样设置条件编译
>例如debug版设置编译选项DEBUG，并且更改不应改变CMakelist.txt

> 使用option command，eg：

>option(DEBUG_mode "ON for debug or OFF for release" ON)

>IF(DEBUG_mode)

>    add_definitions(-DDEBUG)

>ENDIF()

> 使其生效的方法：首先cmake生成makefile，然后make edit_cache编辑编译选项；Linux下会打开一个文本框，可以更改，该完后再make生成目标文件——emacs不支持make edit_cache；

> 局限：这种方法不能直接设置生成的makefile，而是必须使用命令在make前设置参数；对于debug、release版本，相当于需要两个目录，分别先cmake一次，然后分别make edit_cache一次；

> 期望的效果：在执行cmake时直接通过参数指定一个开关项，生成相应的makefile——可以这样做，例如cmake –DDEBUGVERSION=ON

13. 怎样添加编译宏定义
> 使用`add_definitions`命令，见命令部分说明

14.怎样添加编译依赖项
>用于确保编译目标项目前依赖项必须先构建好

>`add_dependencies`

15.怎样指定目标文件目录
> 建立一个新的目录，在该目录中执行cmake生成Makefile文件，这样编译结果会保存在该目录——类似

> SET_TARGET_PROPERTIES(ss7gw PROPERTIES                      RUNTIME_OUTPUT_DIRECTORY "${BIN_DIR}")

16. 很多文件夹，难道需要把每个文件夹编译成一个库文件？
>可以不在子目录中使用CMakeList.txt，直接在上层目录中指定子目录

17. 怎样设定依赖的cmake版本
>cmake_minimum_required(VERSION 2.6)

19. 相对路径怎么指定
> `${projectname_SOURCE_DIR}`表示根源文件目录，`${ projectname _BINARY_DIR}`表示根二进制文件目录？

20. 怎样设置编译中间文件的目录
>> TBD

21. 怎样在IF语句中使用字串或数字比较
>数字比较LESS、GREATER、EQUAL，字串比STRLESS、STRGREATER、STREQUAL，

	>> Eg：
	
	set(CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS ON)
	
	set(AAA abc)
	
	IF(AAA STREQUAL abc)

    message(STATUS "true")   #应该打印true
	
	ENDIF()

22. 更改h文件时是否只编译必须的cpp文件
> 是

23. 机器上安装了VC7和VC8，CMAKE会自动搜索编译器，但是怎样指定某个版本？
> TBD

24. 怎样根据OS指定编译选项
> `IF( APPLE ); IF( UNIX ); IF( WIN32 )`

25. 能否自动执行某些编译前、后命令？
> 可以，TBD

26. 怎样打印make的输出
	
	make VERBOSE=1
    

## Example1: 单个源文件 main.c

## Example2: 分解成多个 main.c hello.h hello.c

## Example3: 先生成一个静态库，链接该库

## Example4: 将源文件放置到不同的目录

## Example5: 控制生成的程序和库所在的目录

## Example6: 使用动态库而不是静态库