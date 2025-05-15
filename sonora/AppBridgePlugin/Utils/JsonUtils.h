#pragma once

#include <juce_core/juce_core.h>

namespace novonotes
{
struct JsonUtils
{
    // ファイルを読み取り、JSONデータを juce::var 型で返す関数
    static juce::var readJsonFromFile(const juce::File& jsonFile)
    {
        auto filePath = jsonFile.getFullPathName();

        if(!jsonFile.existsAsFile())
        {
            juce::Logger::writeToLog("JSON file does not exist: " + filePath);
            return juce::var();  // 空の juce::var を返す
        }

        juce::FileInputStream fileStream(jsonFile);

        if(!fileStream.openedOk())
        {
            juce::Logger::writeToLog("Failed to open JSON file: " + filePath);
            return juce::var();  // 空の juce::var を返す
        }

        juce::var jsonData = juce::JSON::parse(fileStream);

        if(jsonData.isVoid() || !jsonData.isObject())
        {
            juce::Logger::writeToLog("Invalid JSON structure.");
            return juce::var();  // 空の juce::var を返す
        }

        return jsonData;
    }

    static bool writeJsonToFile(const juce::var& jsonData,
                                const juce::String& filePath)
    {
        if(!jsonData.isObject())
        {
            juce::Logger::writeToLog(
                "Provided data is not a valid JSON object.");
            return false;
        }

        juce::File jsonFile(filePath);
        jsonFile.getParentDirectory().createDirectory();
        juce::FileOutputStream fileStream(jsonFile);

        if(!fileStream.openedOk())
        {
            juce::Logger::writeToLog("Failed to open file for writing: " +
                                     filePath);
            return false;
        }

        juce::String jsonString = juce::JSON::toString(jsonData);
        fileStream.writeText(jsonString, false, false, nullptr);

        if(fileStream.getStatus().failed())
        {
            juce::Logger::writeToLog("Failed to write to file: " + filePath);
            return false;
        }

        juce::Logger::writeToLog("Successfully wrote JSON to file: " +
                                 filePath);
        return true;
    }

    // juce::var をデバッグプリントする関数
    static void debugPrintJson(const juce::var& jsonData)
    {
        // フォーマットされた JSON を出力
        juce::Logger::writeToLog(juce::JSON::toString(jsonData, true));
    }
};
}  // namespace novonotes
