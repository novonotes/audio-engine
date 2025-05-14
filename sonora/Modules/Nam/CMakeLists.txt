include(../../CMake/target_source_directory.cmake)

add_library(Nam INTERFACE)

target_include_directories(Nam INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
target_source_directory(Nam PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
