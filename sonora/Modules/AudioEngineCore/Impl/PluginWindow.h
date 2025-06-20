#pragma once

#include <juce_core/juce_core.h>
#include <juce_gui_basics/juce_gui_basics.h>
#include <tracktion_engine/tracktion_engine.h>

namespace te = tracktion;

namespace novonotes
{

inline static bool isDPIAware(te::Plugin&)
{
    // You should keep a DB of if plugins are DPI aware or not and recall that
    // value here. You should let the user toggle the value if the plugin
    // appears tiny
    return true;
}

//==============================================================================
// struct AudioProcessorEditorContentComp : public te::Plugin::EditorComponent
//{
//    AudioProcessorEditorContentComp(te::ExternalPlugin& plug) : plugin(plug)
//    {
//        JUCE_AUTORELEASEPOOL
//        {
//            if(auto pi = plugin.getAudioPluginInstance())
//            {
//                editor.reset(pi->createEditorIfNeeded());
//
//                if(editor == nullptr)
//                    editor =
//                    std::make_unique<GenericAudioProcessorEditor>(*pi);
//
//                addAndMakeVisible(*editor);
//            }
//        }
//
//        resizeToFitEditor(true);
//    }
//
//    bool allowWindowResizing() override { return false; }
//
//    ComponentBoundsConstrainer* getBoundsConstrainer() override
//    {
//        if(editor == nullptr || allowWindowResizing()) return {};
//
//        return editor->getConstrainer();
//    }
//
//    void resized() override
//    {
//        if(editor != nullptr) editor->setBounds(getLocalBounds());
//    }
//
//    void childBoundsChanged(Component* c) override
//    {
//        if(c == editor.get())
//        {
//            plugin.edit.pluginChanged(plugin);
//            resizeToFitEditor();
//        }
//    }
//
//    void resizeToFitEditor(bool force = false)
//    {
//        if(force || !allowWindowResizing())
//            setSize(jmax(8, editor != nullptr ? editor->getWidth() : 0),
//                    jmax(8, editor != nullptr ? editor->getHeight() : 0));
//    }
//
//    te::ExternalPlugin& plugin;
//    std::unique_ptr<AudioProcessorEditor> editor;
//
//    AudioProcessorEditorContentComp() = delete;
//    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(
//        AudioProcessorEditorContentComp)
//};

//=============================================================================
class PluginWindow : public juce::DocumentWindow
{
   public:
    PluginWindow(te::Plugin&);
    ~PluginWindow() override;

    static std::unique_ptr<PluginWindow> create(te::Plugin&);

    void show();

    void setEditor(std::unique_ptr<te::Plugin::EditorComponent>);
    te::Plugin::EditorComponent* getEditor() const { return editor.get(); }

    void recreateEditor();
    void recreateEditorAsync();

   private:
    void moved() override;
    void userTriedToCloseWindow() override
    {
        plugin.windowState->closeWindowExplicitly();
    }
    void closeButtonPressed() override { userTriedToCloseWindow(); }
    float getDesktopScaleFactor() const override { return 1.0f; }

    std::unique_ptr<te::Plugin::EditorComponent> editor;

    te::Plugin& plugin;
    te::PluginWindowState& windowState;
    bool updateStoredBounds = false;
};

//==============================================================================
class ExtendedUIBehaviour : public te::UIBehaviour
{
   public:
    ExtendedUIBehaviour() = default;

    std::unique_ptr<juce::Component> createPluginWindow(
        te::PluginWindowState& pws) override
    {
        if(auto ws = dynamic_cast<te::Plugin::WindowState*>(&pws))
            return PluginWindow::create(ws->plugin);

        return {};
    }

    void recreatePluginWindowContentAsync(te::Plugin& p) override
    {
        if(auto* w =
               dynamic_cast<PluginWindow*>(p.windowState->pluginWindow.get()))
            return w->recreateEditorAsync();

        UIBehaviour::recreatePluginWindowContentAsync(p);
    }
};

}  // namespace novonotes
