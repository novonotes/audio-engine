#include "Settings.h"

#include "Settings/SettingsFile.h"
#include "Utils/JsonUtils.h"

namespace novonotes
{

Settings::Settings(const juce::var& json) : _json(json) {}

juce::String Settings::getCommand() const
{
    if(_json.isObject())
    {
        juce::var command = _json["command"];

        if(command.isString() && !command.toString().isEmpty())
        {
            return command.toString();
        }
    }
    return "";
}

std::vector<juce::String> Settings::getArgs() const
{
    if(_json.isObject())
    {
        juce::var args = _json["args"];

        if(args.isArray())
        {
            auto tmpPtr =  args.getArray();
            std::vector<juce::String> vec;
            for (juce::var item : *tmpPtr)
            {
                vec.emplace_back(item.toString());
            }
            return vec;
        }
    }
    return {};
}

juce::String Settings::getCwd() const
{
    if(_json.isObject())
    {
        juce::var cwd = _json["cwd"];

        if(cwd.isString() && !cwd.toString().isEmpty())
        {
            return cwd.toString();
        }
    }
    return juce::File::getCurrentWorkingDirectory().getFullPathName();
}

bool Settings::getShowDevEditor() const
{
    if(_json.isObject())
    {
        juce::var showDevEditor = _json["showDevEditor"];

        if(showDevEditor.isBool())
        {
            return showDevEditor;
        }
    }
    return false;  // デフォルトはfalse
}

Settings Settings::initialize()
{
    auto settingsFile = getSettingsFile();
    if(!settingsFile.existsAsFile())
    {
        bool result = JsonUtils::writeJsonToFile(
            Settings::createDefaultSettings(), settingsFile.getFullPathName());
        jassert(result);
    }
    auto json = JsonUtils::readJsonFromFile(settingsFile);
    juce::Logger::writeToLog(
        "Settings loaded from file: \n"
        "path=" +
        settingsFile.getFullPathName() +
        "\ndata=" + juce::JSON::toString(json, false));
    return Settings(json);
}

juce::var Settings::createDefaultSettings()
{
    juce::DynamicObject::Ptr jsonObject = new juce::DynamicObject();
    // README に合わせたデフォルトキー名
    jsonObject->setProperty("command", "");
    jsonObject->setProperty("cwd", "");
    jsonObject->setProperty("args", juce::var(juce::Array<juce::var>()));
    jsonObject->setProperty("showDevEditor", false);
    return juce::var(jsonObject);
}

}  // namespace novonotes
