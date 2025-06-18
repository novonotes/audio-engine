# juce_modules という名前のライブラリターゲットを追加する。
function(add_juce_modules_library)
    # プロジェクトを juce_add_* で作成していないので、
    # juce_generate_juce_header() は使用できない。
    add_library(juce_modules STATIC)

    target_link_libraries(juce_modules
        PRIVATE
        juce::juce_core
        juce::juce_audio_utils
        juce::juce_dsp
        juce::juce_audio_processors
        PUBLIC
        juce::juce_recommended_config_flags
        juce::juce_recommended_lto_flags
        juce::juce_recommended_warning_flags
    )

    target_compile_definitions(juce_modules
        PUBLIC
        JUCE_WEB_BROWSER=0
        JUCE_USE_CURL=0
        INTERFACE
        NOMINMAX
        JUCE_MODAL_LOOPS_PERMITTED=1 # juce::MessageManager::runDispatchLoopUntil() を呼び出すために必要
        JUCE_PLUGINHOST_VST3=1
        # JUCE_PLUGINHOST_AU=1
        $<TARGET_PROPERTY:juce_modules,COMPILE_DEFINITIONS>)

    target_include_directories(juce_modules
        INTERFACE
        $<TARGET_PROPERTY:juce_modules,INCLUDE_DIRECTORIES>
    )

    set_target_properties(juce_modules PROPERTIES
        POSITION_INDEPENDENT_CODE TRUE
        VISIBILITY_INLINES_HIDDEN TRUE
        C_VISIBILITY_PRESET hidden
        CXX_VISIBILITY_PRESET hidden)
endfunction()
