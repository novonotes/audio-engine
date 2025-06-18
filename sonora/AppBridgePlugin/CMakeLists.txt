include(${CMAKE_CURRENT_LIST_DIR}/../CMake/target_source_directory.cmake)

set(TARGET_NAME AppBridgePlugin)
project(${TARGET_NAME} VERSION 0.0.1)


set(PRODUCT_NAME "Sonora App Bridge")

juce_add_plugin(${TARGET_NAME}
    VERSION 0.1.0                               # Set this if the plugin version is different to the project version
    # ICON_BIG ...                              # ICON_* arguments specify a path to an image file to use as an icon for the Standalone
    # ICON_SMALL ...
    COMPANY_NAME "NovoNotes and Community Contributors"                          # Specify the name of the plugin's author
    IS_SYNTH TRUE                       # Is this a synth or an effect?
    NEEDS_MIDI_INPUT TRUE               # Does the plugin need midi input?
    NEEDS_MIDI_OUTPUT TRUE              # Does the plugin need midi output?
    # IS_MIDI_EFFECT TRUE/FALSE                 # Is this plugin a MIDI effect?
    # EDITOR_WANTS_KEYBOARD_FOCUS TRUE/FALSE    # Does the editor need keyboard focus?
    COPY_PLUGIN_AFTER_BUILD TRUE                # Should the plugin be installed to a default location after building?
    PLUGIN_MANUFACTURER_CODE Nncc               # A four-character manufacturer id with at least one upper-case character
    PLUGIN_CODE Snab                            # A unique four-character plugin id with exactly one upper-case character
                                                # GarageBand 10.3 requires the first letter to be upper-case, and the remaining letters to be lower-case
    FORMATS AU VST3 Standalone                  # The formats to build. Other valid formats are: AAX Unity VST AU AUv3
    PRODUCT_NAME ${PRODUCT_NAME}                # The name of the final executable, which can differ from the target name
)

target_include_directories(${TARGET_NAME} PRIVATE .)
target_source_directory(${TARGET_NAME} PRIVATE .)

target_compile_definitions(${TARGET_NAME}
    PUBLIC
        JUCE_VST3_CAN_REPLACE_VST2=0
        JUCE_WEB_BROWSER=0
        JUCE_USE_CURL=0 
        # JUCE_PLUGINHOST_AU=1
        # 原因不明だが、ビルドがこけるためコメントアウト。
        # JUCE_PLUGINHOST_VST3=1
        JUCE_DISPLAY_SPLASH_SCREEN=0
)

target_link_libraries(${TARGET_NAME}
    PRIVATE
        juce::juce_audio_utils
        juce::juce_core
        juce::juce_gui_basics
        AudioEngineCore
        ProtoMessageHandler
        SocketIo
    PUBLIC
        juce::juce_recommended_config_flags
        juce::juce_recommended_lto_flags
        juce::juce_recommended_warning_flags
)
