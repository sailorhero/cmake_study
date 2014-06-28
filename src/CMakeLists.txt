include_directories(${PROJECT_BINARY_DIR}/include/)
include_directories(../libhello)

#set(APP_SRC main.cpp)
AUX_SOURCE_DIRECTORY(. APP_SRCS)

add_executable(${PROJECT_NAME} ${APP_SRCS})

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)

#link "libhello" to hello program
target_link_libraries(${PROJECT_NAME} libhello)

###########################################################
# 安装脚本
###########################################################
install(TARGETS ${PROJECT_NAME}
  RUNTIME DESTINATION "bin")


