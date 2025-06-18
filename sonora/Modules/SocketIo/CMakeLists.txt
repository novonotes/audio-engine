include (../../CMake/target_source_directory.cmake)

add_library(SocketIo STATIC)
set_target_properties(SocketIo PROPERTIES POSITION_INDEPENDENT_CODE TRUE)

target_source_directory(SocketIo PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

target_include_directories(SocketIo PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(SocketIo 
    PRIVATE
        AudioEngineCore
    PUBLIC
        ProtoMessageHandler
        Nam
)
