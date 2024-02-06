cmake_minimum_required(VERSION 3.24)

project(versioned_target C CXX)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_C_STANDARD 11)

set(APP_SOURCES main.cpp version/version.c)

add_library(application OBJECT ${APP_SOURCES})
add_executable(${PROJECT_NAME} $<TARGET_OBJECTS:application>)

add_executable(versioned_${PROJECT_NAME} $<TARGET_OBJECTS:application>
                                         version/version_deployed.c)
# target_link_libraries(versioned_${PROJECT_NAME}.elf PRIVATE QORVO::dwt_uwb)
set_property(TARGET versioned_${PROJECT_NAME} PROPERTY EXCLUDE_FROM_ALL TRUE)
