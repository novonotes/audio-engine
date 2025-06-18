

#pragma once
#include <string>

namespace novonotes
{

struct Error
{
    /// 各コードの意味は
    /// [google.protobuf.code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto)
    /// を参照してください。
    enum class Code
    {
        OK = 0,
        CANCELLED = 1,
        UNKNOWN = 2,
        INVALID_ARGUMENT = 3,
        DEADLINE_EXCEEDED = 4,
        NOT_FOUND = 5,
        ALREADY_EXISTS = 6,
        PERMISSION_DENIED = 7,
        RESOURCE_EXHAUSTED = 8,
        FAILED_PRECONDITION = 9,
        ABORTED = 10,
        OUT_OF_RANGE = 11,
        UNIMPLEMENTED = 12,
        INTERNAL = 13,
        UNAVAILABLE = 14,
        DATA_LOSS = 15,
        UNAUTHENTICATED = 16
    };

    Error(std::string d = "", Code c = Code::UNKNOWN) : description(d), code(c)
    {}

    virtual ~Error() = default;
    std::string description;
    Code code;
};
struct InternalError : Error
{
    InternalError(std::string d) : Error(d, Code::INTERNAL) {}
};
struct UnimplementedError : Error
{
    UnimplementedError(std::string d = "Unimplemented feature.")
        : Error(d, Code::UNIMPLEMENTED)
    {}
};

struct UnavailableError : Error
{
    UnavailableError(std::string d = "Temporary Unavailable.")
        : Error(d, Code::UNAVAILABLE)
    {}
};

struct InvalidArgumentError : Error
{
    InvalidArgumentError(std::string d) : Error(d, Code::INVALID_ARGUMENT) {}
};

struct FailedPreconditionError : Error
{
    FailedPreconditionError(std::string d) : Error(d, Code::FAILED_PRECONDITION)
    {}
};

struct IllegalConnectionError : InvalidArgumentError
{
    IllegalConnectionError(std::string d = "Illegal connection.")
        : InvalidArgumentError(d)
    {}
};

struct NotFoundError : Error
{
    NotFoundError(std::string d) : Error(d, Code::NOT_FOUND) {}
};

struct FileNotFoundError : NotFoundError
{
    FileNotFoundError(std::string d = "File not found.") : NotFoundError(d) {}
};

struct AlreadyExistsError : Error
{
    AlreadyExistsError(std::string d) : Error(d, Code::ALREADY_EXISTS) {}
};

}  // namespace novonotes
