cmake_minimum_required(VERSION 3.24)

project(versioned_target C CXX)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_C_STANDARD 11)

add_custom_target(
  _generate_git_sha
  COMMAND
    ${CMAKE_COMMAND}
    -DVERSION_TEMPLATE_FILE=${CMAKE_SOURCE_DIR}/cmake/versioning/version_git_only.c.in
    -DVERSION_SOURCE_FILE=version_git_only.c -P
    ${CMAKE_SOURCE_DIR}/cmake/versioning/git_sha.cmake
  BYPRODUCTS version_git_only.c)

add_custom_target(
  _generate_deploy_version
  COMMAND
    ${CMAKE_COMMAND}
    -DVERSION_TEMPLATE_FILE=${CMAKE_SOURCE_DIR}/cmake/versioning/version_deploy.c.in
    -DVERSION_SOURCE_FILE=version_deploy.c -P
    ${CMAKE_SOURCE_DIR}/cmake/versioning/deploy_version.cmake
  BYPRODUCTS version_deploy.c)

set(APP_SOURCES main.cpp version_git_only.c)

add_library(application OBJECT ${APP_SOURCES})
target_include_directories(application
                           PUBLIC ${CMAKE_SOURCE_DIR}/cmake/versioning)
add_executable(${PROJECT_NAME} $<TARGET_OBJECTS:application>)

add_executable(versioned_${PROJECT_NAME} $<TARGET_OBJECTS:application>
                                         version_deploy.c)
set_property(TARGET versioned_${PROJECT_NAME} PROPERTY EXCLUDE_FROM_ALL TRUE)
