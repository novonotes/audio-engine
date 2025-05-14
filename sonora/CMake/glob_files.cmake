
# ソースファイルを列挙して、第1引数に指定された配列に追加する。
# usage:
# glob_files(
#   <source_list>
#   TARGET_DIRECTORY <target_directory>
#   [RECURSIVE <true|false>]
#   EXTENSIONS <extension1> [<extension2> ...]
#   )
#
#   source_list: 結果を受け取る配列。列挙した結果はこの配列に追加される。
#   TARGET_DIRECTORY: ファイルを列挙するディレクトリ。
#   RECURSIVE: ディレクトリを再帰的に探索するかどうか。デフォルトは true。
#   EXTENSIONS: 列挙対象のファイルの拡張子。`.cpp` のようにドットを含んだ形式で指定すること。(e.g., ".cpp;.h;.hpp;.mm")
function(glob_files SOURCE_LIST)
  cmake_parse_arguments(GF "" "RECURSIVE;TARGET_DIRECTORY" "EXTENSIONS" ${ARGN})

  # GF_RECURSIVE が定義されていて、明示的に false が設定されているとき
  if(DEFINED GF_RECURSIVE AND NOT GF_RECURSIVE)
    set(GLOB_COMMAND "GLOB")
  else()
    set(GLOB_COMMAND "GLOB_RECURSE")
  endif()

  if(NOT DEFINED GF_TARGET_DIRECTORY)
    message(FATAL_ERROR "Target directory must be specified.")
  endif()

  if(NOT DEFINED GF_EXTENSIONS)
    message(FATAL_ERROR "Target extensions must be specified.")
  endif()

  foreach(EXT ${GF_EXTENSIONS})
    file(${GLOB_COMMAND} TMP_LIST LIST_DIRECTORIES false "${GF_TARGET_DIRECTORY}/*${EXT}")
    list(APPEND ${SOURCE_LIST} ${TMP_LIST})
  endforeach()
  set(${SOURCE_LIST} ${${SOURCE_LIST}} PARENT_SCOPE)
endfunction()

