#include "Settings.h"

#include "Settings/SettingsFile.h"
#include "Utils/JsonUtils.h"

namespace novonotes
{

Settings::Settings(const juce::var& json) : _json(json) {}

juce::String Settings::getApplicationPath() const
{
    if(_json.isObject())
    {
        juce::var applicationPath = _json["applicationPath"];

        if(applicationPath.isString() && !applicationPath.toString().isEmpty())
        {
            return applicationPath.toString();
        }
    }

    juce::String defaultPath;

#if JUCE_WINDOWS
    defaultPath =
        juce::File::getSpecialLocation(juce::File::globalApplicationsDirectory)
            .getChildFile("BeatGen")
            .getFullPathName();
#elif JUCE_MAC
    defaultPath =
        juce::File::getSpecialLocation(juce::File::globalApplicationsDirectory)
            .getChildFile("BeatGen")
            .getFullPathName();
#elif JUCE_LINUX
    defaultPath =
        juce::File::getSpecialLocation(juce::File::globalApplicationsDirectory)
            .getChildFile("BeatGen")
            .getFullPathName();
#else
    defaultPath = juce::String();
#endif

    return defaultPath;
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
    jsonObject->setProperty("applicationPath", "");
    jsonObject->setProperty("cwd", "");
    return juce::var(jsonObject);
}

}  // namespace novonotes
