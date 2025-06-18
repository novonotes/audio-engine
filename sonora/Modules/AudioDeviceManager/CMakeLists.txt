include(../../CMake/target_source_directory.cmake)

add_library(AudioDeviceManager STATIC)
set_target_properties(AudioDeviceManager PROPERTIES POSITION_INDEPENDENT_CODE TRUE)

target_source_directory(AudioDeviceManager PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

target_include_directories(AudioDeviceManager PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(AudioDeviceManager
    PUBLIC
        AudioEngineCore
)


