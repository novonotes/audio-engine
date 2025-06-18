

#pragma once

#include <google/protobuf/util/json_util.h>

namespace novonotes
{
inline static std::string protoToJsonString(
    const google::protobuf::Message& message)
{
    google::protobuf::util::JsonPrintOptions options;
    options.add_whitespace = false;
    options.always_print_fields_with_no_presence = true;
    options.always_print_enums_as_ints = false;
    options.preserve_proto_field_names = true;

    std::string json_string;
    auto status = google::protobuf::util::MessageToJsonString(
        message, &json_string, options);

    return json_string;
}
}  // namespace novonotes
