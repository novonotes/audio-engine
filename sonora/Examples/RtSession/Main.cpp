#include <AudioDeviceManager/AudioDeviceManager.h>
#include <ProtoMessageHandler/RtCommandHandler.h>
#include <ProtoMessageHandler/RtStateBroadcaster.h>
#include <SocketIo/UdpChannel.h>

#include "MainComponent.h"

//==============================================================================
class MainApplication final : public juce::JUCEApplication
{
   public:
    //==============================================================================
    MainApplication()
    {
        _engine = std::make_unique<novonotes::AudioEngine>(
            "your-company.rt-session-example-engine.v1",
            "RtSession Exmample App", false);
        _deviceManager =
            std::make_unique<novonotes::AudioDeviceManager>(*_engine);
        _handler = std::make_unique<novonotes::ProtoMessageHandler>(*_engine);
        _udpChannel = std::make_unique<novonotes::UdpChannel>(*_handler);
    }

    const juce::String getApplicationName() override
    {
        return "RtSession Example App";
    }
    const juce::String getApplicationVersion() override { return "0.1.0"; }
    bool moreThanOneInstanceAllowed() override { return true; }

    //==============================================================================
    void initialise(const juce::String& commandLine) override
    {
        juce::ignoreUnused(commandLine);

        bool result = _udpChannel->startReceiving(8081);
        assert(result);

        _mainWindow =
            std::make_unique<MainWindow>(getApplicationName(), *_engine);
    }

    void shutdown() override
    {
        _mainWindow.reset();
        _deviceManager.reset();
        _engine.reset();
        _udpChannel.reset();
    }

    //==============================================================================
    void systemRequestedQuit() override { quit(); }

    void anotherInstanceStarted(const juce::String& commandLine) override
    {
        juce::ignoreUnused(commandLine);
    }

    class MainWindow final : public juce::DocumentWindow
    {
       public:
        explicit MainWindow(juce::String name, novonotes::AudioEngine& engine)
            : DocumentWindow(name,
                             juce::Desktop::getInstance()
                                 .getDefaultLookAndFeel()
                                 .findColour(backgroundColourId),
                             allButtons)
        {
            setUsingNativeTitleBar(true);
            setContentOwned(new MainComponent(engine), true);

#if JUCE_IOS || JUCE_ANDROID
            setFullScreen(true);
#else
            setResizable(true, true);
            centreWithSize(getWidth(), getHeight());
#endif

            setVisible(true);
        }

        void closeButtonPressed() override
        {
            getInstance()->systemRequestedQuit();
        }

       private:
        JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(MainWindow)
    };

   private:
    std::unique_ptr<MainWindow> _mainWindow;
    std::unique_ptr<novonotes::AudioEngine> _engine;
    std::unique_ptr<novonotes::AudioDeviceManager> _deviceManager;
    std::unique_ptr<novonotes::UdpChannel> _udpChannel;
    std::unique_ptr<novonotes::ProtoMessageHandler> _handler;
};

//==============================================================================
// This macro generates the main() routine that launches the app.
START_JUCE_APPLICATION(MainApplication)
