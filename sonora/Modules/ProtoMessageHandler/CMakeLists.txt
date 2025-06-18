include(../../CMake/target_source_directory.cmake)

add_library(ProtoMessageHandler STATIC)
set_target_properties(ProtoMessageHandler PROPERTIES POSITION_INDEPENDENT_CODE TRUE)

target_source_directory(ProtoMessageHandler PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

target_include_directories(ProtoMessageHandler PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(ProtoMessageHandler
    PRIVATE
        AudioEngineCore
    PUBLIC
        AudioEngineProto
)

