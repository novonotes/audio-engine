
include(../../CMake/target_source_directory.cmake)

set(TARGET_NAME "AudioEngineExamplePlugin")

if(DEFINED ENV{COPY_PLUGIN_AFTER_BUILD} AND "$ENV{COPY_PLUGIN_AFTER_BUILD}")
    set(COPY_PLUGIN_AFTER_BUILD_FLAG TRUE)
else()
    set(COPY_PLUGIN_AFTER_BUILD_FLAG FALSE)
endif()

message(STATUS "COPY_PLUGIN_AFTER_BUILD: ${COPY_PLUGIN_AFTER_BUILD_FLAG}")

juce_add_plugin(${TARGET_NAME}
    # VERSION ...                               # Set this if the plugin version is different to the project version
    # ICON_BIG ...                              # ICON_* arguments specify a path to an image file to use as an icon for the Standalone
    # ICON_SMALL ...
    # COMPANY_NAME ...                          # Specify the name of the plugin's author
    IS_SYNTH TRUE                               # Is this a synth or an effect?
    NEEDS_MIDI_INPUT TRUE                       # Does the plugin need midi input?
    NEEDS_MIDI_OUTPUT TRUE                      # Does the plugin need midi output?
    # IS_MIDI_EFFECT TRUE/FALSE                 # Is this plugin a MIDI effect?
    # EDITOR_WANTS_KEYBOARD_FOCUS TRUE/FALSE    # Does the editor need keyboard focus?
    COPY_PLUGIN_AFTER_BUILD ${COPY_PLUGIN_AFTER_BUILD_FLAG}              # Should the plugin be installed to a default location after building?
    PLUGIN_MANUFACTURER_CODE Manf               # A four-character manufacturer id with at least one upper-case character
    PLUGIN_CODE Dem1                            # A unique four-character plugin id with exactly one upper-case character
                                                # GarageBand 10.3 requires the first letter to be upper-case, and the remaining letters to be lower-case
    FORMATS AU VST3                             # The formats to build. Other valid formats are: AAX Unity VST AU AUv3
    PRODUCT_NAME "Audio Engine Example Plugin")        # The name of the final executable, which can differ from the target name

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
        JUCE_WEB_BROWSER=0  # If you remove this, add `NEEDS_WEB_BROWSER TRUE` to the `juce_add_plugin` call
        JUCE_USE_CURL=0     # If you remove this, add `NEEDS_CURL TRUE` to the `juce_add_plugin` call
        JUCE_VST3_CAN_REPLACE_VST2=0
        ASSETS_DIR="${ASSETS_DIR}"
)

target_link_libraries(${TARGET_NAME}
    PRIVATE
        juce::juce_audio_utils
        juce::juce_audio_processors
        AudioEngineCore
    PUBLIC
        juce::juce_recommended_config_flags
        juce::juce_recommended_lto_flags
        juce::juce_recommended_warning_flags
)
