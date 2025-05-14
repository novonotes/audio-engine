#pragma once

namespace novonotes
{
/**
 * @brief Get the appropriate log directory based on the operating system.
 *
 * @return juce::File The log directory.
 *
 *  Return paths:
 *   - macOS:    ~/Library/Logs/[applicationName]/
 *   - Windows:  C:\Users\[UserName]\AppData\Local\[applicationName]\Logs\
 *   - Linux:    ~/.config/[applicationName]/logs/
 *   - iOS:      [App Sandbox]/Library/Logs/[applicationName]/
 */
inline juce::File getLogDirectory(juce::String applicationName)
{
#if JUCE_MAC
    return juce::File::getSpecialLocation(
               juce::File::userApplicationDataDirectory)
        .getChildFile("Logs")
        .getChildFile(applicationName);
#elif JUCE_WINDOWS
    return juce::File::getSpecialLocation(juce::File::windowsLocalAppData)
        .getChildFile(applicationName)
        .getChildFile("Logs");
#elif JUCE_LINUX
    return juce::File::getSpecialLocation(
               juce::File::userApplicationDataDirectory)
        .getChildFile(applicationName)
        .getChildFile("logs");
#elif JUCE_IOS
    return juce::File::getSpecialLocation(
               juce::File::userApplicationDataDirectory)
        .getChildFile("Logs")
        .getChildFile(applicationName);
#else
    static_assert(false, "Unsupported OS.");
#endif
}

inline juce::File getLogFile(juce::String applicationName)
{
    auto time = juce::Time::getCurrentTime();
    auto formattedTime = time.formatted("%Y-%m-%d-%H%M%S");

    juce::File logDirectory = getLogDirectory(applicationName);
    return logDirectory.getChildFile(formattedTime + "-" +
                                     juce::String(getProcessId()) + ".log");
}
}  // namespace novonotes
