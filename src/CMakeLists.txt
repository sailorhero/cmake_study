include_directories(${PROJECT_BINARY_DIR}/include)
include_directories(${PROJECT_SOURCE_DIR}/libhello)

#set(APP_SRC main.cpp)
AUX_SOURCE_DIRECTORY(. APP_SRCS)

add_executable(${PROJECT_NAME} ${APP_SRCS})

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)

#link "libhello" to hello program
target_link_libraries(hello libhello)

###########################################################
# 安装脚本
###########################################################
install(TARGETS hello
  RUNTIME DESTINATION "bin")


