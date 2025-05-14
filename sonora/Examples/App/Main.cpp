#include <AudioDeviceManager/AudioDeviceManager.h>

#include "MainComponent.h"

//==============================================================================
class MainApplication final : public juce::JUCEApplication
{
   public:
    //==============================================================================
    MainApplication()
    {
        _engine = std::make_unique<novonotes::AudioEngine>(
            "your-company.example-app-engine.v1", "Audio Engine Exmample App",
            false);
        _deviceManager =
            std::make_unique<novonotes::AudioDeviceManager>(*_engine);
    }

    const juce::String getApplicationName() override
    {
        return "Audio Engine Example App";
    }
    const juce::String getApplicationVersion() override { return "0.1.0"; }
    bool moreThanOneInstanceAllowed() override { return true; }

    //==============================================================================
    void initialise(const juce::String& commandLine) override
    {
        juce::ignoreUnused(commandLine);

        _mainWindow =
            std::make_unique<MainWindow>(getApplicationName(), *_engine);
    }

    void shutdown() override
    {
        _mainWindow = nullptr;
        _deviceManager = nullptr;
        _engine = nullptr;
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
};

//==============================================================================
// This macro generates the main() routine that launches the app.
START_JUCE_APPLICATION(MainApplication)
