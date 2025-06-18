#include "Scenario.h"

#include <assert.h>

static std::string generateUniqueId()
{
    // JUCEのUUID生成機能を使用
    return juce::Uuid().toString().toStdString();
}

static void addScenario(std::vector<Scenario>& scenarios,
                        const juce::String& title,
                        Scenario::CallbackFunction callback)
{
    scenarios.emplace_back(title, callback);
}

/// 再生停止を伴う scenario など、Standalone のみ対応の場合、この関数で scenario
/// を追加する。
///  再生停止はプラグインの場合ホストのDAWで行う。
static void addStandaloneOnlyScenario(std::vector<Scenario>& scenarios,
                                      const juce::String& title,
                                      Scenario::CallbackFunction callback)
{
#if defined(JucePlugin_Build_AU)
#elif defined(JucePlugin_Build_VST3)
#else
    scenarios.emplace_back(title, callback);
#endif
}

static void addPluginOnlyScenario(std::vector<Scenario>& scenarios,
                                  const juce::String& title,
                                  Scenario::CallbackFunction callback)
{
#if defined(JucePlugin_Build_AU) || defined(JucePlugin_Build_VST3)
    scenarios.emplace_back(title, callback);
#endif
}

std::vector<Scenario> createScenarios(novonotes::AudioEngine& engine)
{
    auto& studio = engine.getStudioService();
    auto& transport = engine.getTransportService();
    auto& arrangement = engine.getArrangementService();
    auto& debugUtility = engine.getDebugUtilityService();
    std::vector<Scenario> scenarios;
    addScenario(scenarios, "Play test tone",
                [&debugUtility]() { debugUtility.testTone(); });
    addScenario(scenarios, "Output debug log", []() {
        novonotes::Logger::debug("'Output debug log' is clicked.");
    });
    addScenario(scenarios, "Reset state", [&engine]() { engine.resetState(); });
    addStandaloneOnlyScenario(scenarios, "Start playback from the beggining",
                              [&transport]() {
                                  transport.setPlayheadPosition({0});
                                  transport.startPlay();
                              });
    addStandaloneOnlyScenario(scenarios, "Stop playback",
                              [&transport]() { transport.stopPlay(); });
    addScenario(scenarios, "Enable 1-bar loop", [&transport]() {
        transport.setLoopRange({0}, {4});
        transport.enableLoop();
    });
    addPluginOnlyScenario(scenarios, "Add 1-beat offset to playback position",
                          [&transport]() { transport.setOffset({1}); });
    addScenario(scenarios, "Scan plugins", [&studio]() {
        studio.scanPlugins({"/Library/Audio/Plug-Ins/VST3"});
    });
    addScenario(scenarios, "List device descriptors", [&studio]() {
        auto descriptors = studio.listDeviceDescriptors();
        for(auto desc : descriptors)
        {
            DBG("--------------------------");
            DBG("deviceTypeId: " + desc.deviceTypeId.value);
            DBG("displayName: " + desc.displayName);
            DBG("pluginFormatName: " + desc.pluginFormatName);
            for(auto cat : desc.categories)
            {
                DBG("category: " + cat);
            }
            DBG("manufacturerName: " + desc.manufacturerName);
            DBG("version: " + desc.version);
        }
        DBG("--------------------------");
        DBG("Results: " + juce::String(descriptors.size()));
    });
    {
        struct ListenerImpl : novonotes::DeviceStateListener
        {
            void deviceStateChanged(const juce::String& serializedState)
            {
                DBG("DeviceStateChanged: " + serializedState);
            }
        };
        static ListenerImpl listener;
        addScenario(scenarios, "Start monitoring device state change",
                    [&studio]() { studio.addDeviceStateListener(&listener); });
        addScenario(
            scenarios, "Stop monitoring device state change",
            [&studio]() { studio.removeDeviceStateListener(&listener); });
    }
    addScenario(scenarios, "Create a track with an audio region",
                [&arrangement, &studio]() {
                    auto trackId = arrangement.createAudioTrack();
                    juce::File assetsDir{ASSETS_DIR};
                    arrangement.addAudioRegion(
                        trackId, assetsDir.getChildFile("example.wav"),
                        novonotes::BeatPosition{0}, std::nullopt, {"region-1"});
                    studio.connect(trackId, novonotes::AudioOutputTag{});
                });
    addScenario(
        scenarios, "Create a track and a reverb device",
        [&arrangement, &studio]() {
            auto trackId = arrangement.createAudioTrack();
            juce::File assetsDir{ASSETS_DIR};
            arrangement.addAudioRegion(
                trackId, assetsDir.getChildFile("example.wav"),
                novonotes::BeatPosition{0}, std::nullopt, {"region-2"});

            // Reverb のデバイスを作成。
            novonotes::DeviceInstanceId deviceId{generateUniqueId()};
            studio.createDeviceInstance({"TracktionInternal-Reverb-c84ee9d2-0"},
                                        deviceId);

            // Device Instance の情報を表示。
            auto instance = studio.getDeviceInstance(deviceId);
            {
                DBG("DeviceInstance:");
                DBG("  id: " << instance.id.value);
                DBG("  deviceTypeId: " << instance.deviceTypeId.value);
                DBG("  parameters:");

                for(const auto& parameter : instance.parameters)
                {
                    DBG("    Parameter:");
                    DBG("      parameterId: " << parameter.parameterId.value);
                    DBG("      displayName: " << parameter.displayName);
                    DBG("      textCurrentValue: "
                        << parameter.textCurrentValue);
                    DBG("      textDefaultValue: "
                        << parameter.textDefaultValue);
                }

                DBG("\nDevice Internal State: ");
                DBG(instance.serializedState);
            }

            // 接続の作成
            studio.connect(trackId, deviceId);
            studio.connect(deviceId, novonotes::AudioOutputTag{});
        });

    // AmbienceEnhancer Lite needs to be installed to your system.
    // The free installer is available at `https://novo-notes.com/labz`.
    addScenario(
        scenarios, "Use external VST plugin", [&studio, &arrangement]() {
            auto trackId = arrangement.createAudioTrack();
            juce::File assetsDir{ASSETS_DIR};
            arrangement.addAudioRegion(
                trackId, assetsDir.getChildFile("example.wav"),
                novonotes::BeatPosition{0}, std::nullopt, {"region-3"});

            // 外部 VST の Ambience Enhancer Lite のデバイスを作成。
            novonotes::DeviceInstanceId deviceId{generateUniqueId()};
            studio.createDeviceInstance(
                {"VST3-Ambience Enhancer Lite-5f117d73-eea0fd48"}, deviceId);

            // 接続の作成
            studio.connect(trackId, deviceId);
            studio.connect(deviceId, novonotes::AudioOutputTag{});

            // Device window の表示
            studio.showDeviceWindow(deviceId, false);
        });

    addStandaloneOnlyScenario(
        scenarios, "Change volume while audio playback",
        [&studio, &arrangement, &transport]() {
            auto trackId = arrangement.createAudioTrack();
            juce::File assetsDir{ASSETS_DIR};
            arrangement.addAudioRegion(
                trackId, assetsDir.getChildFile("example.wav"),
                novonotes::BeatPosition{0}, std::nullopt, {"region-4"});

            // VolumeControl のデバイスを作成
            novonotes::DeviceInstanceId volumeDeviceId{generateUniqueId()};
            studio.createDeviceInstance(
                {"TracktionInternal-Volume and Pan-cfaae71a-0"},
                volumeDeviceId);

            // 接続の作成
            studio.connect(trackId, volumeDeviceId);
            studio.connect(volumeDeviceId, novonotes::AudioOutputTag{});

            // 先頭から再生
            transport.setPlayheadPosition({0});
            transport.startPlay();

            // 状態確認のためのディレイ間隔と最初の待ち時間（ms単位）
            const int delayIntervalMs =
                100;              // 状態確認の間隔（後から変更可能）
            const int t0 = 1600;  // 初回のディレイ（2秒後）
            const novonotes::ParameterId paramId{"volume"};

            // [1] 初期状態の確認とパラメータ変更開始の通知
            executeAfterDelay(
                [&studio, volumeDeviceId, paramId]() {
                    bool isChanging =
                        studio.isParameterChanging(volumeDeviceId, paramId);
                    // 変更前は false であることを確認
                    assert(isChanging == false);
                    studio.beginParameterChange(volumeDeviceId, paramId);
                },
                t0);

            // [2] beginParameterChange 後、delayIntervalMs 後に状態確認
            executeAfterDelay(
                [&studio, volumeDeviceId, paramId]() {
                    bool isChanging =
                        studio.isParameterChanging(volumeDeviceId, paramId);
                    // begin 直後は変更中 (true) であるはず
                    assert(isChanging == true);
                },
                t0 + delayIntervalMs);

            // [3] パラメータ値の更新
            executeAfterDelay(
                [&studio, volumeDeviceId, paramId]() {
                    float val = studio.stringToParameterValue(volumeDeviceId,
                                                              paramId, "-12dB");
                    studio.setParameterBaseValue(volumeDeviceId, paramId, val);
                },
                t0 + 2 * delayIntervalMs);

            // [4] setParameter 後、delayIntervalMs 後に状態確認＆変更終了の通知
            executeAfterDelay(
                [&studio, volumeDeviceId, paramId]() {
                    bool isChanging =
                        studio.isParameterChanging(volumeDeviceId, paramId);
                    // 値更新直後も変更中 (true) であると予想
                    assert(isChanging == true);
                    studio.endParameterChange(volumeDeviceId, paramId);
                },
                t0 + 3 * delayIntervalMs);

            // [5] endParameterChange 後、delayIntervalMs 後に状態確認し再生再開
            executeAfterDelay(
                [&studio, volumeDeviceId, paramId]() {
                    bool isChanging =
                        studio.isParameterChanging(volumeDeviceId, paramId);
                    // 終了後は変更状態が解除され、false であるはず
                    assert(isChanging == false);
                },
                t0 + 4 * delayIntervalMs);

            // さらに 2秒後に再生を停止し、トラックを削除する
            executeAfterDelay(
                [&transport, &arrangement, trackId]() {
                    transport.stopPlay();
                    arrangement.deleteTrack(trackId);
                },
                4000);
        });
    return scenarios;
}
