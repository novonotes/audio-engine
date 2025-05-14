# flutter のテスト実行のスクリプト。テストファイルごとに、 実行前に flutter clean を実行する。
# flutter clean なしだと、integration test が CI 上でスタックする問題があった。これを回避することがこのスクリプトの目的。

#!/bin/bash

# 絶対パスを取得する関数
get_abs_path() {
  if command -v realpath > /dev/null 2>&1; then
    realpath "$1"
  elif command -v readlink > /dev/null 2>&1; then
    readlink -f "$1"
  else
    echo "Error: Neither 'realpath' nor 'readlink' is available." >&2
    exit 1
  fi
}

# 引数分割
TEST_DIR=$1
shift # 最初の引数（テストディレクトリ）を除去
FLUTTER_ARGS="$@" # 残りの引数を全て取得

# 指定されたディレクトリから再帰的に _test.dart で終わるファイルを検索
test_files=$(find "$TEST_DIR" -type f -name "*_test.dart")

# test_files が空でないか確認
if [ -z "$test_files" ]; then
  echo "No test files found in directory: $TEST_DIR"
  exit 1
fi

# flutter clean を実行
flutter clean

# 成功と失敗したテストファイルのリストを初期化
successful_tests=()
failed_tests=()

# test ファイルごとに flutter test を実行し、引数を転送
for test_file in $test_files; do
  absolute_test_file=$(get_abs_path "$test_file") # 絶対パスに変換
  echo "----------------------------------"
  echo "Running tests for $absolute_test_file"
  echo "----------------------------------"

  flutter test "$absolute_test_file" $FLUTTER_ARGS 

  # flutter test の終了コードを確認
  EXIT_CODE=$?

  if [ $EXIT_CODE -eq 0 ]; then
    successful_tests+=("$absolute_test_file")
  else
    echo "❌ 'flutter test' exited with non-zero exit code. (code=$EXIT_CODE)"
    failed_tests+=("$absolute_test_file")
  fi
done

# 結果の表示
echo "----------------------------------"
echo "Integration Test Result"
echo "Total test files run: $((${#successful_tests[@]} + ${#failed_tests[@]}))"
echo "Successful test files: ${#successful_tests[@]}"
echo "Failed test files: ${#failed_tests[@]}"
echo "----------------------------------"
echo "Successful test files:"
for test in "${successful_tests[@]}"; do
  echo "$test"
done

# スクリプトの終了ステータスを設定
if [ ${#failed_tests[@]} -ne 0 ]; then
  echo "----------------------------------"
  echo "Failed test files:"
  for test in "${failed_tests[@]}"; do
    echo "$test"
  done
  exit 1
else
  exit 0
fi
