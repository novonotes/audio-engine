
#include <AudioEngineCore/Utils/Logger.h>

namespace novonotes
{

Logger::Logger(const juce::File& file,
               const juce::int64 maxInitialFileSizeBytes,
               bool enableConsoleOutput)
    : _logFile(file)
    , _interProcessLock("LoggerLock")
    , _consoleOutputEnabled(enableConsoleOutput)
{
    if(maxInitialFileSizeBytes >= 0)
        trimFileSize(_logFile, maxInitialFileSizeBytes);

    if(_interProcessLock.enter(1000))
    {
        if(!file.exists())
        {
            file.create();  // (to create the parent directories)
            writeHeader("Unknown");
        }

        _interProcessLock.exit();
    }
    else
    {
        DBG("Error: Could not acquire lock to confirm if the log file "
            "exists: ");
        DBG(file.getFullPathName());
    }
}

Logger::~Logger() {}

//==============================================================================

static juce::String formatTime(const juce::Time& time)
{
    auto tmp = time.toISO8601(true);
    juce::String output = tmp.replace("T", " ");
    // タイムゾーン情報を削除
    int tzPos = output.indexOf("+");
    if(tzPos != -1)
    {
        output = output.substring(0, tzPos);
    }
    return output;
}

void Logger::logMessage(const juce::String& message)
{
    if(_consoleOutputEnabled)
    {
        DBG(message);
    }
    if(_interProcessLock.enter(1000))
    {
        juce::FileOutputStream out(_logFile, 256);

        auto time = juce::Time::getCurrentTime();

        out << "[" << formatTime(time) << "] " << message << juce::newLine;

        _interProcessLock.exit();
    }
    else
    {
        DBG("Error: Could not acquire lock to write to log file: ");
        DBG(message);
    }
}

void Logger::trimFileSize(const juce::File& file, juce::int64 maxFileSizeBytes)
{
    if(maxFileSizeBytes <= 0)
    {
        if(_interProcessLock.enter(1000))
        {
            file.deleteFile();
            _interProcessLock.exit();
        }
        else
        {
            DBG("Error: Could not acquire lock to delete log file: ");
            DBG(file.getFullPathName());
        }
        return;
    }
    if(_interProcessLock.enter(1000))
    {
        const juce::int64 fileSize = file.getSize();

        if(fileSize > maxFileSizeBytes)
        {
            juce::TemporaryFile tempFile(file);

            {
                juce::FileOutputStream out(tempFile.getFile());
                juce::FileInputStream in(file);

                if(!(out.openedOk() && in.openedOk()))
                {
                    _interProcessLock.exit();
                    return;
                }

                in.setPosition(fileSize - maxFileSizeBytes);

                for(;;)
                {
                    const char c = in.readByte();
                    if(c == 0) return;

                    if(c == '\n' || c == '\r')
                    {
                        out << c;
                        break;
                    }
                }

                out.writeFromInputStream(in, -1);
            }

            tempFile.overwriteTargetFileWithTemporary();
        }
        _interProcessLock.exit();
    }
    else
    {
        DBG("Error: Could not acquire lock to trim log file size: ");
        DBG(file.getFullPathName());
    }
}

void Logger::writeHeader(const juce::String& serverInstanceId)
{
    if(_interProcessLock.enter(1000))
    {
        juce::FileOutputStream out(_logFile, 256);

        if(out.openedOk())
        {
            out.setPosition(0);  // ファイルの先頭に書き込む
            out << "# server_instance_id: " << serverInstanceId
                << juce::newLine;
            out << "# entry_format: [$dateTime] $message" << juce::newLine;
        }
        else
        {
            DBG("Error: Could not open log file for writing header: ");
            DBG(_logFile.getFullPathName());
        }

        _interProcessLock.exit();
    }
    else
    {
        DBG("Error: Could not acquire lock to write header to log file: ");
        DBG(_logFile.getFullPathName());
    }
}

}  // namespace novonotes
