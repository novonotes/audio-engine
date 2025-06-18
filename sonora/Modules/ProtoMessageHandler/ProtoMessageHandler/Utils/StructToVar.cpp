#include "StructToVar.h"

#include "juce_core/juce_core.h"

using namespace juce;

juce::var convertProtobufStruct(const google::protobuf::Struct& protoStruct)
{
    // DynamicObject のインスタンスを生成して、各フィールドを設定する
    DynamicObject* obj = new DynamicObject();

    // Struct の各フィールド (キーと値) を変換して DynamicObject に追加
    for(const auto& field : protoStruct.fields())
    {
        obj->setProperty({field.first}, convertProtobufValue(field.second));
    }
    return var(obj);
}

juce::var convertProtobufValue(const google::protobuf::Value& value)
{
    switch(value.kind_case())
    {
        case google::protobuf::Value::kNullValue:
            // null_value は null を表現しています。ここでは void の var
            // を返しています。
            return var();

        case google::protobuf::Value::kNumberValue:
            return var(value.number_value());

        case google::protobuf::Value::kStringValue:
            return var(value.string_value());

        case google::protobuf::Value::kBoolValue:
            return var(value.bool_value());

        case google::protobuf::Value::kStructValue:
            return convertProtobufStruct(value.struct_value());

        case google::protobuf::Value::kListValue:
        {
            // ListValue の場合、各要素を変換して配列（var
            // オブジェクト）に追加する
            var array;
            for(const auto& item : value.list_value().values())
            {
                array.append(convertProtobufValue(item));
            }
            return array;
        }

        default:
            return var();
    }
}
