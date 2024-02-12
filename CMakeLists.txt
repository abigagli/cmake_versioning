cmake_minimum_required(VERSION 3.24)

project(cmake_versioning C CXX)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_C_STANDARD 11)

include(cmake/versioning/targets.cmake)

set(APP_SOURCES main.cpp version_git_only.c)

add_library(application OBJECT ${APP_SOURCES})
target_include_directories(application
                           PUBLIC ${CMAKE_SOURCE_DIR}/cmake/versioning)
add_executable(${PROJECT_NAME} $<TARGET_OBJECTS:application>)

add_executable(versioned_${PROJECT_NAME} $<TARGET_OBJECTS:application>
                                         version_deploy.c)
set_property(TARGET versioned_${PROJECT_NAME} PROPERTY EXCLUDE_FROM_ALL TRUE)

add_deploy_target_for(
  versioned_${PROJECT_NAME} $<TARGET_FILE:versioned_${PROJECT_NAME}> GMAPP
  ${CMAKE_SOURCE_DIR}/images/${CMAKE_BUILD_TYPE}
  ${CMAKE_SOURCE_DIR}/scripts/deploy_with_crc_and_version.sh)
