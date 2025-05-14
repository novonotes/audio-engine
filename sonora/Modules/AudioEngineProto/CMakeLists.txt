include(../../CMake/target_source_directory.cmake)

if(NOT DEFINED ENV{GRPC_INSTALLER_DIR} OR "$ENV{GRPC_INSTALLER_DIR}" STREQUAL "")
message(FATAL_ERROR "GRPC_INSTALLER_DIR must be specified as an environment variable.")
endif()

set(TARGET_GRPC_VERSION v1.68.2)

include($ENV{GRPC_INSTALLER_DIR}/cmake/grpc.cmake)

add_library(AudioEngineProto)
target_source_directory(AudioEngineProto PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(AudioEngineProto PROPERTIES
    POSITION_INDEPENDENT_CODE TRUE
)

target_include_directories(AudioEngineProto
PUBLIC
    ${Protobuf_INCLUDE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}
)
target_link_libraries(AudioEngineProto
PUBLIC
    ${_PROTOBUF_LIBPROTOBUF}
)