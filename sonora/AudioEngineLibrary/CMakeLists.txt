include(../CMake/glob_files.cmake)

if(NOT DEFINED ENV{NOVONOTES_DUO_FLUTTER_SDK_DIR} OR "$ENV{NOVONOTES_DUO_FLUTTER_SDK_DIR}" STREQUAL "")
    message(FATAL_ERROR "NOVONOTES_DUO_FLUTTER_SDK_DIR must be set.")
endif()

set(DART_SDK_DIR "$ENV{NOVONOTES_DUO_FLUTTER_SDK_DIR}/bin/cache/dart-sdk")

set(TARGET_NAME AudioEngineLibrary)

if(CMAKE_SYSTEM_NAME STREQUAL "iOS")
  add_library(${TARGET_NAME} SHARED)
  set_target_properties(${TARGET_NAME} PROPERTIES
    OUTPUT_NAME "Sonora"
    FRAMEWORK TRUE
    FRAMEWORK_VERSION A
    MACOSX_FRAMEWORK_IDENTIFIER com.novo-notes.${TARGET_NAME}
    MACOSX_FRAMEWORK_SHORT_VERSION_STRING "1.0"
    MACOSX_FRAMEWORK_BUNDLE_VERSION "1"
    POSITION_INDEPENDENT_CODE TRUE
  )
else()
  add_library(${TARGET_NAME} MODULE)
  set_target_properties(${TARGET_NAME} PROPERTIES
      OUTPUT_NAME "Sonora"  
      POSITION_INDEPENDENT_CODE TRUE
  )
endif()

target_source_directory(${TARGET_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

# Dynamically Linked Dart API を使用するために、
# Dart SDK のソースをプロジェクトに追加する。
glob_files(DART_SDK_SOURCES TARGET_DIRECTORY ${DART_SDK_DIR} RECURSIVE true EXTENSIONS ".c")
target_sources(${TARGET_NAME} PRIVATE ${DART_SDK_SOURCES})

target_link_libraries(${TARGET_NAME}
    PRIVATE
    ProtoMessageHandler
    AudioDeviceManager
    Nam
    SocketIo
)

target_compile_options(${TARGET_NAME}
    PUBLIC
    $<$<CONFIG:Debug>:-DDEBUG -D_DEBUG>
    $<$<CXX_COMPILER_ID:AppleClang,Clang,GNU>:-Werror=return-type -fvisibility=hidden>
    $<$<CXX_COMPILER_ID:MSVC>:/source-charset:utf-8 /Zc:__cplusplus>
)

target_include_directories(${TARGET_NAME}
    PRIVATE
    ${DART_SDK_DIR}/include
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/Include
)

target_compile_definitions(${TARGET_NAME}
    PUBLIC
    Duo_VersionString=\"${DUO_VERSION}\"
    NOVONOTES_DLL=1
)

if(CMAKE_SYSTEM_NAME STREQUAL "iOS")
  set(DESTINATION_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../dart/audio_engine_flutter_libs/ios/Frameworks")
  add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E make_directory "${DESTINATION_PATH}"
    COMMAND ${CMAKE_COMMAND} -E copy_directory
      "$<TARGET_BUNDLE_DIR:${TARGET_NAME}>"
      "${DESTINATION_PATH}/AudioEngine.framework"
  )
endif()
