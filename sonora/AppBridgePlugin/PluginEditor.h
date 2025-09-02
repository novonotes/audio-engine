#pragma once

#include "PluginProcessor.h"
#include <juce_audio_processors/juce_audio_processors.h>
#include <juce_gui_basics/juce_gui_basics.h>

using namespace juce;

namespace novonotes
{

class PluginEditor : public AudioProcessorEditor, public Timer
{
public:
    PluginEditor(PluginProcessor& p);
    ~PluginEditor() override;

    void paint(Graphics& g) override;
    void resized() override;
    void timerCallback() override;

private:
    void updateConnectionStatus();
    void updateAppName();
    void onRelaunchClicked();
    void onCancelClicked();
    void onSettingsClicked();
    String getAppNameFromCommand(const String& command);

    PluginProcessor& _processor;
    
    String _currentAppName;
    bool _indicatorVisible = true;  // Linking/Reconnecting時の点滅用
    
    Label _titleLabel;
    Label _versionLabel;
    Label _appNameLabel;
    Label _statusLabel;
    Label _hintLabel;
    TextButton _relaunchButton{"Relaunch"};
    TextButton _cancelButton{"Cancel"};
    TextButton _settingsButton{"Settings"};
    
    std::unique_ptr<Component> _debugView;
    bool _showingSettings = false;
    
    // カスタムLookAndFeel for smaller button text
    class SmallButtonLookAndFeel : public LookAndFeel_V4
    {
    public:
        Font getTextButtonFont(TextButton&, int) override
        {
            return Font("Helvetica Neue", 12.0f, Font::plain);
        }
    };
    SmallButtonLookAndFeel _smallButtonLF;
    
    // 設定モーダル用のコンポーネント
    class SettingsModal : public Component
    {
    public:
        SettingsModal(PluginEditor& editor);
        void paint(Graphics& g) override;
        void resized() override;
        void mouseUp(const MouseEvent& e) override;
        
    private:
        PluginEditor& _editor;
        TextButton _closeButton{"Close"};
        HyperlinkButton _githubLink;
        Label _pathLabel;
        Label _infoLabel;
    };
    
    std::unique_ptr<SettingsModal> _settingsModal;
    
    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(PluginEditor)
};

}  // namespace novonotes
