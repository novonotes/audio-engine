# RtSession 機能の新規開発用のアプリケーション
# メンテナンスする必要はないと思うので、動かなくなったら削除で良いと思う。

include(../../CMake/target_source_directory.cmake)

set(TARGET_NAME RtSessionExampleService)

juce_add_gui_app(${TARGET_NAME}
    PRODUCT_NAME ${TARGET_NAME}
) 

target_source_directory(${TARGET_NAME}
    PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
)

target_source_directory(${TARGET_NAME}
    PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/../Common
)

target_include_directories(${TARGET_NAME} PRIVATE 
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/../Common
)

get_filename_component(ASSETS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../../assets" ABSOLUTE)

target_compile_definitions(${TARGET_NAME}
    PUBLIC
    JUCE_WEB_BROWSER=0
    JUCE_USE_CURL=0 
    ASSETS_DIR="${ASSETS_DIR}"
)

target_link_libraries(${TARGET_NAME}
    PRIVATE
        SocketIo
        AudioDeviceManager
        juce::juce_core
        juce::juce_gui_basics
        juce::juce_events
    PUBLIC
        juce::juce_recommended_config_flags
        juce::juce_recommended_warning_flags
)

