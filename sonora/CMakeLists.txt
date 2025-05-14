######################################################################
# CMake Settings
######################################################################

cmake_minimum_required(VERSION 3.22)

# JUCE 側の問題でこの警告がでるっぽい。JUCE をアップデートすれば、この Warning は出ないはず。
# JUCE アップデート後この行は削除すべき。
# https://forum.juce.com/t/cmake-3-31-0-warning/63941
set(CMAKE_POLICY_DEFAULT_CMP0175 OLD)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

message(STATUS "CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME}")

# Platform specific settings
if(CMAKE_SYSTEM_NAME STREQUAL "iOS")
  set(CMAKE_FRAMEWORK TRUE)
  set(CMAKE_OSX_DEPLOYMENT_TARGET 15)
elseif(APPLE)
  set(CMAKE_OSX_DEPLOYMENT_TARGET 10.14)
  message(STATUS CMAKE_OSX_ARCHITECTURES: ${CMAKE_OSX_ARCHITECTURES})
endif()

if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Debug CACHE STRING "Choose the build type (Debug, Release, etc.)" FORCE)
endif()

######################################################################
# Project Settings
######################################################################


project(AudioEngine VERSION 0.0.1)

set(DEPENDENCIES_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../../Dependencies")

add_subdirectory(${DEPENDENCIES_DIR}/tracktion_engine/modules/juce JUCE) 

add_subdirectory(Modules)
add_subdirectory(AudioEngineLibrary)
add_subdirectory(AudioEngineService)
add_subdirectory(Examples)
