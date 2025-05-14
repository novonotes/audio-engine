
set(TARGET_NAME AudioEngineService)

juce_add_console_app(${TARGET_NAME}
    PRODUCT_NAME ${TARGET_NAME}
) 

target_sources(${TARGET_NAME} PRIVATE
    Main.cpp
)

target_compile_definitions(${TARGET_NAME}
    PUBLIC
    JUCE_WEB_BROWSER=0
    JUCE_USE_CURL=0 
)

target_link_libraries(${TARGET_NAME}
    PRIVATE
        AudioDeviceManager
        SocketIo
        juce::juce_core
        juce::juce_gui_basics
        juce::juce_events
    PUBLIC
        juce::juce_recommended_config_flags
        juce::juce_recommended_warning_flags
)

