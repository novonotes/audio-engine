/*
  ==============================================================================

   This file is part of the JUCE library.
   Copyright (c) 2022 - Raw Material Software Limited

   JUCE is an open source library subject to commercial or open-source
   licensing.

   The code included in this file is provided under the terms of the ISC license
   http://www.isc.org/downloads/software-support-policy/isc-license. Permission
   To use, copy, modify, and/or distribute this software for any purpose with or
   without fee is hereby granted provided that the above copyright notice and
   this permission notice appear in all copies.

   JUCE IS PROVIDED "AS IS" WITHOUT ANY WARRANTY, AND ALL WARRANTIES, WHETHER
   EXPRESSED OR IMPLIED, INCLUDING MERCHANTABILITY AND FITNESS FOR PURPOSE, ARE
   DISCLAIMED.

  ==============================================================================
*/
#pragma once
#include <juce_core/juce_core.h>

namespace novonotes
{

//==============================================================================
/**
    An implementation of juce::Logger interface for NovoNotes Audio Engine.

    @see Logger

    @tags{Core}
*/
class Logger : public juce::Logger
{
   public:
    //==============================================================================
    static constexpr int defaultMaxInitialFileSizeBytes = 128 * 1024;
    /** Creates a Logger for a given file.

        @param fileToWriteTo    the file that to use - new messages will be
       appended to the file. If the file doesn't exist, it will be created,
                                along with any parent directories that are
       needed.
        @param maxInitialFileSizeBytes  if this is zero or greater, then if the
       file already exists but is larger than this number of bytes, then the
       start of the file will be truncated to keep the size down. This prevents
       a log file getting ridiculously large over time. The file will be
       truncated at a new-line boundary. If this value is less than zero, no
       size limit will be imposed; if it's zero, the file will always be
       deleted. Note that the size is only checked once when this object is
       created - any logging that is done later will be appended without any
       checking
    */
    Logger(const juce::File& fileToWriteTo,
           const juce::int64 maxInitialFileSizeBytes =
               defaultMaxInitialFileSizeBytes,
           bool enableConsoleLog = false);

    Logger(const juce::File& fileToWriteTo, bool enableConsoleLog)
        : Logger(fileToWriteTo, defaultMaxInitialFileSizeBytes,
                 enableConsoleLog)
    {}

    /** Destructor. */
    ~Logger() override;

    //==============================================================================

    // (implementation of the Logger virtual method)
    void logMessage(const juce::String&) override;

    static void debug(const juce::String& message)
    {
#if JUCE_DEBUG
        juce::Logger::writeToLog("[debug] " + message);
#endif
    }
    static void info(const juce::String& message)
    {
        juce::Logger::writeToLog("[info] " + message);
    }
    static void notice(const juce::String& message)
    {
        juce::Logger::writeToLog("[notice] " + message);
    }
    static void warn(const juce::String& message)
    {
        juce::Logger::writeToLog("[warn] " + message);
    }
    static void error(const juce::String& message)
    {
        juce::Logger::writeToLog("[error] " + message);
    }
    static void critical(const juce::String& message)
    {
        juce::Logger::writeToLog("[critical] " + message);
    }
    static void alert(const juce::String& message)
    {
        juce::Logger::writeToLog("[alert] " + message);
    }
    static void emergency(const juce::String& message)
    {
        juce::Logger::writeToLog("[emergency] " + message);
    }
    static void writeStartUpMessage(const juce::String& appName,
                                    const juce::String& appVersion)
    {
        notice(appName + " " + appVersion);
    }
    void writeHeader(const juce::String& serverInstanceId);

   private:
    //==============================================================================
    juce::File _logFile;
    juce::InterProcessLock _interProcessLock;
    bool _consoleOutputEnabled;

    /** This is a utility function which removes lines from the start of a text
        file to make sure that its total size is below the given size.
    */
    void trimFileSize(const juce::File& file, juce::int64 maxFileSize);

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(Logger)
};

}  // namespace novonotes
