#!/bin/bash
#set -eux
set -eu

SRC_P=$(pwd)

gen_gtags() {
    find "${SRC_P}" -type f | grep -E "\\.(c|h|cc|cpp|hpp)$" > gtags.files
    gtags
    rm gtags.files
}

gen_json() {
    if [[ -f "${SRC_P}/CMakeLists.txt" ]]; then
        BUILD_PATH=tmp-build-path
        mkdir -p "${BUILD_PATH}"
        cd "${BUILD_PATH}" || return
        cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON "${SRC_P}"
        cp compile_commands.json "${SRC_P}"
        cd "${SRC_P}" || return
        rm -rf "${BUILD_PATH}"
    else
        make clean
        bear make
    fi
}

print_usage_exit() {
    echo "Usage:"
    echo "./gen-index.sh"
    echo "./gen-index.sh [g|j|a]"
    exit 0
}

case "$#" in
    0)
        gen_json
        ;;
    1)
        case "$1" in
            "g")
                gen_gtags
                ;;
            "j")
                gen_json
                ;;
            "a")
                gen_gtags
                gen_json
                ;;
            *)
                print_usage_exit
                ;;
        esac
        ;;
    *)
        print_usage_exit
        ;;
esac

### for path exclude ###
#
# $ mkdir a b c d e
# $ touch a/1 b/2 c/3 d/4 e/5 e/a e/b
# $ find . -type f ! -path "./a/*" ! -path "./b/*"
#
# ./d/4
# ./c/3
# ./e/a
# ./e/b
# ./e/5
