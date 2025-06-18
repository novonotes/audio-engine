include(../../CMake/add_juce_modules_library.cmake)
include(../../CMake/target_source_directory.cmake)

######################################################################################
# Interface
######################################################################################

add_juce_modules_library()

add_library(AudioEngineCore INTERFACE)

target_include_directories(AudioEngineCore INTERFACE Include)

target_source_directory(AudioEngineCore PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/Include)

target_link_libraries(AudioEngineCore
    INTERFACE
        AudioEngineCoreImpl
        juce_modules
)

######################################################################################
# Implementation
######################################################################################

set(DEPENDENCIES_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../Dependencies")

juce_add_module(${DEPENDENCIES_DIR}/tracktion_engine/modules/tracktion_core)
juce_add_module(${DEPENDENCIES_DIR}/tracktion_engine/modules/tracktion_graph)
juce_add_module(${DEPENDENCIES_DIR}/tracktion_engine/modules/tracktion_engine)

# Do not link this library directly. Link AudioEngineCore instead.
add_library(AudioEngineCoreImpl STATIC)

set_target_properties(AudioEngineCoreImpl PROPERTIES
    OUTPUT_NAME "AudioEngineCore"  
    POSITION_INDEPENDENT_CODE TRUE
)

target_source_directory(AudioEngineCoreImpl PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/Impl)

target_link_libraries(AudioEngineCoreImpl 
    PRIVATE 
        AudioEngineCore
        tracktion_engine
        juce_modules
)

# On Linux
if(UNIX AND NOT APPLE)
  target_link_libraries(AudioEngineCoreImpl PUBLIC atomic)
endif()
