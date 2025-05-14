# APIs のスキーマ定義に基に、protoc でコード生成。生成後clang-format を適用。

#!/bin/bash

set -e -u -o pipefail

APIS_DIR="../apis"
OUTPUT_DIR="./Modules/AudioEngineProto"
GRPC_VERSION="v1.68.2"
PROTOC_COMMAND="$GRPC_INSTALLER_DIR/$GRPC_VERSION/install-macOS-universal/bin/protoc"

mkdir -p "${OUTPUT_DIR}"

echo "PROTOC_COMMAND: $PROTOC_COMMAND"
echo "protoc version:"
$PROTOC_COMMAND --version 

rm -rf $OUTPUT_DIR/google
rm -rf $OUTPUT_DIR/novonotes

$PROTOC_COMMAND -I=$APIS_DIR --cpp_out=$OUTPUT_DIR \
    google/protobuf/{struct,field_mask,duration,timestamp,any,empty}.proto \
    $APIS_DIR/google/api/*.proto \
    $APIS_DIR/google/rpc/*.proto \
    $(find $APIS_DIR/novonotes/audio_engine -name "*.proto")


# Format
find $OUTPUT_DIR -name '*.cc' -o -name '*.h' | xargs clang-format -i --style file
# なぜか2回以上適用しないと出力が同じにならない。
find $OUTPUT_DIR -name '*.cc' -o -name '*.h' | xargs clang-format -i --style file