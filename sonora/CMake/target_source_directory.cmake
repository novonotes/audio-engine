

include(${CMAKE_CURRENT_LIST_DIR}/glob_files.cmake)

# SRC_BASE_DIR 内の .cpp, .h, .hpp, .mm ファイルを source_group にまとめ、TARGET_NAME で指定された target の source として追加する
# ライブラリの package の ソースコードをプラグインの target に追加するときなどに使う
function(target_source_directory TARGET_NAME SCOPE SRC_BASE_DIR)
    if(NOT TARGET ${TARGET_NAME})
        message(FATAL_ERROR "${TARGET_NAME} is not a target name.")
    endif()

    unset(SRC_FILES)

    glob_files(
        SRC_FILES
        TARGET_DIRECTORY ${SRC_BASE_DIR}
        EXTENSIONS ".cpp;.h;.hpp;.mm;.cc;.c"
    )

    source_group(TREE ${SRC_BASE_DIR} FILES ${SRC_FILES})

    target_sources(${TARGET_NAME}
        ${SCOPE}
        ${SRC_FILES})
endfunction()