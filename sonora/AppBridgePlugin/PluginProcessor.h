#pragma once

#include <AudioEngineCore/AudioEngine.h>
#include <AudioEngineCore/Utils/Logger.h>
#include <SocketIo/SocketClient.h>
#include <SocketIo/UdpChannel.h>
#include <juce_audio_processors/juce_audio_processors.h>
#include <juce_core/juce_core.h>

#include <cstdint>

#include "Settings/Settings.h"

using namespace juce;

namespace novonotes
{
class PluginProcessor : public AudioProcessor
{
   public:
    //==============================================================================
    PluginProcessor();
    ~PluginProcessor() override;
    //==============================================================================
    void prepareToPlay(double sampleRate, int expectedBlockSize) override;

    void releaseResources() override {}

    using AudioProcessor::processBlock;
    void processBlock(AudioBuffer<float> &buffer, MidiBuffer &midi) override;

    //==============================================================================
    AudioProcessorEditor *createEditor() override;
    bool hasEditor() const override { 
#ifdef DEBUG
        return true;
#else
        return false;
#endif
    }

    //==============================================================================
    const String getName() const override { return "Sonora App Bridge"; }
    const String getVersion() const { return "0.1.0"; }
    bool acceptsMidi() const override { return true; }
    bool producesMidi() const override { return true; }
    double getTailLengthSeconds() const override { return 0; }

    //==============================================================================
    int getNumPrograms() override { return 1; }
    int getCurrentProgram() override { return 0; }
    void setCurrentProgram(int) override {}
    const String getProgramName(int) override { return {}; }
    void changeProgramName(int, const String &) override {}

    //==============================================================================
    void getStateInformation(MemoryBlock &) override;
    void setStateInformation(const void *, int) override;

    //==============================================================================
    bool isBusesLayoutSupported(const BusesLayout &layouts) const override;

    AudioEngine &getEngine()
    {
        assert(_engine != nullptr && "AudioEngine is not initialized");
        return *_engine;
    }

   private:
    std::unique_ptr<AudioEngine> _engine;
    std::unique_ptr<ProtoMessageHandler> _handler;
    std::unique_ptr<SocketClient> _client;
    std::unique_ptr<UdpChannel> _udpChannel;

    Settings _settings;

    juce::String _sockPath = "";

    // エンジンとアプリのリンクが完了したかどうか。
    std::atomic<bool> _linkCompleted = false;

    // エンジンとアプリのリンク処理が現在実行中かどうか。
    // false を代入することでキャンセル可能。
    std::atomic<bool> _isLinking = false;

    CallbackThread _thread;

    template <typename Function>
    void callFunctionOnMessageThread(Function &&func)
    {
        if(MessageManager::getInstance()->isThisTheMessageThread())
        {
            func();
        }
        else
        {
            jassert(!MessageManager::getInstance()
                         ->currentThreadHasLockedMessageManager());
            WaitableEvent finishedSignal;
            MessageManager::callAsync([&] {
                func();
                finishedSignal.signal();
            });
            finishedSignal.wait(-1);
        }
    }

    // linkWithApp
    /// 自身でアプリケーションをサブプロセスで起動し、アドレスを変えながら繰り返し接続試行する。
    /// ただし、2回目以降のこのメソッド呼び出しは無視される。
    void linkWithApp();

   private:
    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(PluginProcessor)
};
}  // namespace novonotes
