# APIs のスキーマ定義に基に、protoc でコード生成。

#!/bin/bash
set -e

APIS_DIR="../../../APIs"
ENGINE_PLUGIN_DIR="../audio_engine_protoc_plugin"
OUTPUT_DIR="./lib/src/generated"

cd $ENGINE_PLUGIN_DIR && dart pub get && cd -
echo "Starting code generation..."

rm -rf $OUTPUT_DIR/google
rm -rf $OUTPUT_DIR/novonotes

protoc -I=$APIS_DIR --dart_out=$OUTPUT_DIR \
    google/protobuf/{struct,field_mask,duration,timestamp,any,empty}.proto \
    $APIS_DIR/google/api/*.proto \
    $APIS_DIR/google/rpc/*.proto \
    $(find $APIS_DIR/novonotes/audio_engine -name "*.proto")
protoc -I=$APIS_DIR --engine_out=$OUTPUT_DIR --plugin=$ENGINE_PLUGIN_DIR/bin/protoc-gen-engine \
    $APIS_DIR/novonotes/audio_engine/v1alpha1/*.proto \
    $APIS_DIR/novonotes/audio_engine/v1alpha1/type/body_type.proto 

echo "Code generation completed."