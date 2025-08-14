#include "PluginEditor.h"
#include "PluginDevEditor.h"
#include "Settings/SettingsFile.h"

namespace novonotes
{

PluginEditor::PluginEditor(PluginProcessor& p)
    : AudioProcessorEditor(p)
    , _processor(p)
{
    // settings.jsonのshowDevEditorに応じてサイズを設定
    bool showDevEditor = _processor.getSettings().getShowDevEditor();
    if (showDevEditor)
    {
        setSize(380, 400);  // Dev Editorを表示する場合
    }
    else
    {
        setSize(380, 180);
    }
    
    // タイトルラベル（バージョンを含む）
    _titleLabel.setText("Sonora App Bridge v" + _processor.getVersion(), dontSendNotification);
    _titleLabel.setFont(Font("Helvetica Neue", 12.0f, Font::plain));
    _titleLabel.setJustificationType(Justification::centredLeft);
    _titleLabel.setColour(Label::textColourId, Colour(0xff999999));
    addAndMakeVisible(_titleLabel);
    
    // バージョンラベルは使わない
    _versionLabel.setVisible(false);
    
    // アプリ名ラベル
    _appNameLabel.setFont(Font("Helvetica Neue", 18.0f, Font::plain));
    _appNameLabel.setJustificationType(Justification::centred);
    addAndMakeVisible(_appNameLabel);
    
    // ステータスラベル
    _statusLabel.setFont(Font("Helvetica Neue", 18.0f, Font::bold));
    _statusLabel.setJustificationType(Justification::centred);
    addAndMakeVisible(_statusLabel);
    
    // Relaunchボタン
    _relaunchButton.onClick = [this] { onRelaunchClicked(); };
    _relaunchButton.setVisible(false);
    _relaunchButton.setColour(TextButton::buttonColourId, Colour(0xff1a1a1a));
    _relaunchButton.setColour(TextButton::buttonOnColourId, Colour(0xff2a2a2a));
    _relaunchButton.setColour(TextButton::textColourOffId, Colour(0xffcccccc));
    addAndMakeVisible(_relaunchButton);
    
    // 設定ボタン
    _settingsButton.setButtonText("Settings");
    _settingsButton.onClick = [this] { onSettingsClicked(); };
    _settingsButton.setColour(TextButton::buttonColourId, Colour(0xff2a2a2a));
    _settingsButton.setColour(TextButton::buttonOnColourId, Colour(0xff3a3a3a));
    _settingsButton.setColour(TextButton::textColourOffId, Colour(0xff808080));
    _settingsButton.setLookAndFeel(&_smallButtonLF);
    addAndMakeVisible(_settingsButton);
    
    // settings.jsonの設定に応じてDev Editorを表示
    if (_processor.getSettings().getShowDevEditor())
    {
        _debugView = std::make_unique<PluginDevEditor>(_processor);
        addAndMakeVisible(_debugView.get());
    }
    
    updateAppName();
    updateConnectionStatus();
    
    // 定期的に状態を更新
    startTimerHz(2);
}

PluginEditor::~PluginEditor()
{
    stopTimer();
    _settingsButton.setLookAndFeel(nullptr);
}

void PluginEditor::paint(Graphics& g)
{
    // 単色背景
    g.fillAll(Colour(0xff1a1a1a));
    
    // ヘッダーセパレータ
    g.setColour(Colour(0xff2a2a2a));
    g.drawHorizontalLine(30, 0, getWidth());
    
    // 接続状態に応じた色
    Colour statusColour;
    switch (_connectionStatus)
    {
        case ConnectionStatus::Connected:
            statusColour = Colour(0xff00d4aa);  // シアングリーン
            break;
        case ConnectionStatus::Connecting:
            statusColour = Colour(0xffffb700);  // アンバー
            break;
        case ConnectionStatus::Disconnected:
            statusColour = Colour(0xff888888);  // グレー
            break;
    }
    
    // ステータスインジケーター（ドット）
    // CONNECTED テキストの左に配置
    Font statusFont("Helvetica Neue", 18.0f, Font::bold);
    auto statusText = _statusLabel.getText();
    auto textWidth = statusFont.getStringWidth(statusText);
    auto centerX = getWidth() * 0.5f;
    auto indicatorX = centerX - (textWidth * 0.5f) - 18.0f;
    auto indicatorY = 95.0f;  // 少し下に配置
    
    // グロー効果（1.5倍サイズ）
    g.setColour(statusColour.withAlpha(0.15f));
    g.fillEllipse(indicatorX - 9, indicatorY - 9, 18, 18);
    
    // メインドット（1.5倍サイズ）
    g.setColour(statusColour);
    g.fillEllipse(indicatorX - 4.5f, indicatorY - 4.5f, 9, 9);
}

void PluginEditor::resized()
{
    auto bounds = getLocalBounds();
    
    // ヘッダーエリア（タイトルと設定ボタン）
    auto headerBounds = bounds.removeFromTop(30);
    _titleLabel.setBounds(headerBounds.removeFromLeft(200).reduced(10, 5));
    _settingsButton.setBounds(headerBounds.removeFromRight(80).reduced(5, 6));
    
    // メインコンテンツエリア
    bounds.removeFromTop(20);
    
    // アプリ名
    _appNameLabel.setBounds(bounds.removeFromTop(30));
    
    // ステータス
    _statusLabel.setBounds(bounds.removeFromTop(30));
    
    // Relaunchボタン（未接続時のみ）
    if (_connectionStatus == ConnectionStatus::Disconnected)
    {
        bounds.removeFromTop(10);
        auto buttonArea = bounds.removeFromTop(30).reduced(100, 3);
        _relaunchButton.setBounds(buttonArea);
    }
    
    // Dev Editorが有効な場合、残りの領域に配置
    if (_debugView)
    {
        bounds.removeFromTop(20);
        _debugView->setBounds(bounds.reduced(10, 5));
    }
}

void PluginEditor::timerCallback()
{
    updateConnectionStatus();
}

void PluginEditor::updateConnectionStatus()
{
    ConnectionStatus oldStatus = _connectionStatus;
    
    // 実際の接続状態を取得
    bool connected = _processor.isConnected();
    
    if (connected)
    {
        _connectionStatus = ConnectionStatus::Connected;
    }
    else
    {
        // TODO: 接続中の状態を適切に判定する方法を実装
        _connectionStatus = ConnectionStatus::Disconnected;
    }
    
    if (oldStatus != _connectionStatus)
    {
        String statusText;
        Colour textColour;
        
        switch (_connectionStatus)
        {
            case ConnectionStatus::Connected:
                statusText = "CONNECTED";
                textColour = Colour(0xff00d4aa);
                _relaunchButton.setVisible(false);
                break;
            case ConnectionStatus::Connecting:
                statusText = "CONNECTING...";
                textColour = Colour(0xffffb700);
                _relaunchButton.setVisible(false);
                break;
            case ConnectionStatus::Disconnected:
                statusText = "DISCONNECTED";
                textColour = Colour(0xff888888);
                _relaunchButton.setVisible(true);
                break;
        }
        
        _statusLabel.setText(statusText, dontSendNotification);
        _statusLabel.setColour(Label::textColourId, textColour);
        
        resized();
        repaint();
    }
}

void PluginEditor::updateAppName()
{
    // settings.json から command フィールドを取得
    try
    {
        auto settings = Settings::initialize();
        String command = settings.getCommand();
        _currentAppName = getAppNameFromCommand(command);
        _appNameLabel.setText(_currentAppName.toUpperCase(), dontSendNotification);
        _appNameLabel.setColour(Label::textColourId, Colour(0xff909090));
    }
    catch (...)
    {
        _appNameLabel.setText("NOT CONFIGURED", dontSendNotification);
        _appNameLabel.setColour(Label::textColourId, Colour(0xff404040));
    }
}

String PluginEditor::getAppNameFromCommand(const String& command)
{
    // スラッシュ区切りの最後のセグメントを取得
    auto segments = StringArray::fromTokens(command, "/", "");
    if (segments.size() > 0)
    {
        return segments[segments.size() - 1];
    }
    return "Unknown";
}

void PluginEditor::onRelaunchClicked()
{
    Logger::writeToLog("Relaunch button clicked");
    
    // 接続中状態にする
    _connectionStatus = ConnectionStatus::Connecting;
    updateConnectionStatus();
    
    // アプリを再起動
    _processor.relaunchApp();
}

void PluginEditor::onSettingsClicked()
{
    if (!_showingSettings)
    {
        _showingSettings = true;
        _settingsModal = std::make_unique<SettingsModal>(*this);
        addAndMakeVisible(_settingsModal.get());
        _settingsModal->setBounds(getLocalBounds());
    }
}

// SettingsModal の実装
PluginEditor::SettingsModal::SettingsModal(PluginEditor& editor)
    : _editor(editor)
    , _githubLink("Setup Guide", URL("https://github.com/novonotes/audio-engine/tree/main/sonora/AppBridgePlugin/README.md"))
{
    // 設定ファイルのパスを取得
    auto settingsPath = getSettingsFile();
    
    // パスラベル
    _pathLabel.setText(settingsPath.getFullPathName(), dontSendNotification);
    _pathLabel.setFont(Font("Monaco", 14.0f, Font::plain));
    _pathLabel.setJustificationType(Justification::centred);
    _pathLabel.setColour(Label::textColourId, Colour(0xffb0b0b0));
    addAndMakeVisible(_pathLabel);
    
    // 情報ラベル
    _infoLabel.setText("Edit this file to configure the App Bridge.", dontSendNotification);
    _infoLabel.setFont(Font("Helvetica Neue", 16.0f, Font::plain));
    _infoLabel.setJustificationType(Justification::centred);
    _infoLabel.setColour(Label::textColourId, Colour(0xff808080));
    addAndMakeVisible(_infoLabel);
    
    // GitHubリンク
    _githubLink.setColour(HyperlinkButton::textColourId, Colour(0xff00d4aa));
    _githubLink.setFont(Font("Helvetica Neue", 16.0f, Font::plain), false);
    addAndMakeVisible(_githubLink);
    
    // 閉じるボタン
    _closeButton.onClick = [this] {
        _editor._showingSettings = false;
        _editor._settingsModal.reset();
    };
    _closeButton.setColour(TextButton::buttonColourId, Colour(0xff2a2a2a));
    _closeButton.setColour(TextButton::textColourOffId, Colour(0xff999999));
    addAndMakeVisible(_closeButton);
}

void PluginEditor::SettingsModal::paint(Graphics& g)
{
    // 半透明の黒背景
    g.fillAll(Colour(0xee000000));
    
    // モーダルボックス（余白なし）
    auto modalBounds = getLocalBounds();
    
    // 単色背景
    g.setColour(Colour(0xff2a2a2a));
    g.fillRect(modalBounds);
    
    // ボーダー
    g.setColour(Colour(0xff3a3a3a));
    g.drawRect(modalBounds, 1);
    
    // タイトル
    g.setColour(Colour(0xffcccccc));
    g.setFont(Font("Helvetica Neue", 20.0f, Font::plain));
    g.drawText("Settings", modalBounds.removeFromTop(35), Justification::centred);
}

void PluginEditor::SettingsModal::resized()
{
    auto bounds = getLocalBounds().reduced(20, 10);
    bounds.removeFromTop(35);  // タイトル分（縮小）
    
    _pathLabel.setBounds(bounds.removeFromTop(40));
    bounds.removeFromTop(2);  // 行間をさらに詰める
    
    _infoLabel.setBounds(bounds.removeFromTop(30));
    bounds.removeFromTop(15);
    
    // DocumentationとCloseボタンを同じ行に配置
    auto buttonArea = bounds.removeFromTop(35);
    _githubLink.setBounds(buttonArea.removeFromLeft(buttonArea.getWidth() / 2).reduced(10, 3));
    _closeButton.setBounds(buttonArea.reduced(10, 3));
}

void PluginEditor::SettingsModal::mouseUp(const MouseEvent& e)
{
    // モーダル外をクリックしたら閉じる（余白がないのでこの機能は無効）
    // モーダル全体がクリック可能領域なので、背景クリックでは閉じない
}

}  // namespace novonotes